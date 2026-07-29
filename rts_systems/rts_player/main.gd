extends Node
# meta default

## enums
## const
const SCRIPT_RTS_CAMERA: Script = preload("../rts_camera/main.gd")
const  SCRIPT_SELECTION_MANAGER: Script = preload("../selection_manager/main.gd")
const SCRIPT_MAP_MANAGER: Script = preload("../rts_objects/components/map/map.gd")
## public vars
## private vars
var _mouse_dragbox_start_position: Vector2 = Vector2.ZERO
var _mouse_dragbox_end_position: Vector2 = Vector2.ZERO
var _player_selection: Array[CharacterBody2D] = []
var _is_dragging: bool = false
## onready vars
@onready var obj_rts_camera: SCRIPT_RTS_CAMERA = $"../RtsCamera"
@onready var obj_selection_manager: SCRIPT_SELECTION_MANAGER = $SelectionManager
@onready var obj_map_manager: SCRIPT_MAP_MANAGER = $"../NavigationRegion2D/Map2"
## built-in overide methods


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_camera_inputs(obj_rts_camera, delta)
	update_selection_dragbox()
		
func move_units_to_mouse() -> void:
	var line = _line(obj_rts_camera.get_global_mouse_position(), _player_selection.size(), 4, 35)
	for index in _player_selection.size():
		var object = _player_selection[index]
		object.new_path(line[index])

func update_player_selection(new_obj_selection: Array[CharacterBody2D]) -> void:
	obj_selection_manager.deselect_array(_player_selection)
	_player_selection = new_obj_selection
	obj_selection_manager.select_array(_player_selection)
	
func update_selection_dragbox() -> void:
	# Left mouse button pressed: start the box
	if Input.is_action_just_pressed(&"input_action_mouseclick_left"):
		_is_dragging = true
		var mouse_position := obj_rts_camera.get_global_mouse_position()
		_mouse_dragbox_start_position = mouse_position
		_mouse_dragbox_end_position = mouse_position
		obj_selection_manager.dragbox_hide()


	# Left mouse button held: resize the box
	if Input.is_action_pressed(&"input_action_mouseclick_left") and _is_dragging:
		_mouse_dragbox_end_position = obj_rts_camera.get_global_mouse_position()

		var dragbox_rectangle = Rect2(
			_mouse_dragbox_start_position,
			_mouse_dragbox_end_position - _mouse_dragbox_start_position
		).abs()
		obj_selection_manager.update_selection_rectangle(dragbox_rectangle)
		


	# Left mouse button released: select units
	if Input.is_action_just_released(&"input_action_mouseclick_left") and _is_dragging:
		var dragbox_rectangle = Rect2(
			_mouse_dragbox_start_position,
			_mouse_dragbox_end_position - _mouse_dragbox_start_position
		).abs()
		var rect_tile = obj_map_manager.obj_ground_tile_layer.get_tiles_in_rect(dragbox_rectangle)
		if dragbox_rectangle.get_area() > obj_selection_manager.DRAGBOX_MIN_SIZE:
			# Dragbox Selection Method
			var units: Array[CharacterBody2D] = []
			for tile in rect_tile:
				if obj_map_manager.get_units().has(tile):
					units.append_array(obj_map_manager.get_units()[tile])
			update_player_selection(
				obj_selection_manager.get_dragbox_select_objects(
				units,
				dragbox_rectangle
				)
			)
			_is_dragging = false
			_mouse_dragbox_start_position = Vector2.ZERO
			_mouse_dragbox_end_position = Vector2.ZERO
			obj_selection_manager.dragbox_hide()
		else:
			# Single Selection Method
			update_player_selection([])
			var mouse_position: Vector2 = obj_rts_camera.get_global_mouse_position()
			var mouse_cell: Vector2i = obj_map_manager.obj_ground_tile_layer.get_tile_location(mouse_position)
			var scan_cell = obj_map_manager.get_neighboors(mouse_cell)
			for cell in scan_cell:
				if obj_map_manager.get_units().has(cell):
					for object:CharacterBody2D in obj_map_manager.get_units()[cell]:
						if obj_selection_manager.select_object_by_sprite(
							object,
							get_viewport().get_camera_2d()):
								update_player_selection([object])
								break
						
	if Input.is_action_just_released(&"input_action_mouseclick_right"):
		if _player_selection.size() > 0 and !get_tree().get_first_node_in_group("selected-object"):
			move_units_to_mouse()
						
## private methods
func _line(position: Vector2, amount: int, max_per_line: int = 4, spacing: float = 35) -> Array[Vector2]:
	var n_lines = ceili(amount / float(max_per_line))
	var x_half = floori(max_per_line / 2.)
	if max_per_line % 2 == 0:
		x_half -= 0.5
	var y_half = floori(n_lines / 2.0)
	if n_lines % 2 == 0:
		y_half -= 0.5
	var y = -spacing * y_half
	var remaining = amount
	var positions: Array[Vector2] = []
	for i in n_lines:
		var n = min(max_per_line, remaining)
		var x = spacing*(-x_half + (max_per_line - n)/2.0)
		for j in n:
			positions.append(position + Vector2(y, x))
			x += spacing
			remaining -=1
		y += spacing
	return positions
	
func _camera_pan(camera: SCRIPT_RTS_CAMERA, delta: float) -> void:
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CONFINED:
		return
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	var viewport_size: Vector2 = get_viewport().get_visible_rect().size
	camera.camera_pan(mouse_pos, viewport_size, delta)
	
func _camera_inputs(camera:  SCRIPT_RTS_CAMERA, delta: float) -> void:
	_camera_pan(camera, delta)
