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
	var mouse_position = obj_rts_camera.get_global_mouse_position()
	var line = _line(mouse_position, _player_selection.size(), 4, 35)
	for index in _player_selection.size():
		var object = _player_selection[index]
		Scripts.RTS_WORLD.new_path(object, line[index])

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
		# Set the layer to unit
		if dragbox_rectangle.get_area() > obj_selection_manager.DRAGBOX_MIN_SIZE:
			# Dragbox Selection Method
			var object_on_tiles = Scripts.DATABASE.DATABASE_UNITS[Scripts.PREFAB_LIST.UNIT_WOKER][Scripts.OBJDATA.TILE_POSIITONS]
			var layer = Scripts.DATABASE.DATABASE_UNITS[Scripts.PREFAB_LIST.UNIT_WOKER][Scripts.OBJDATA.TILEMAPLAYERS]
			var rect_tile = Scripts.TILE_MANAGER.get_tiles_in_rect(layer, dragbox_rectangle)
			var units: Array[CharacterBody2D] = []
			for tile in rect_tile:
				if object_on_tiles.has(tile):
					units.append_array(object_on_tiles[tile])
			update_player_selection(
				obj_selection_manager.get_dragbox_select_objects(
				units,
				dragbox_rectangle)
			)
			_is_dragging = false
			_mouse_dragbox_start_position = Vector2.ZERO
			_mouse_dragbox_end_position = Vector2.ZERO
			obj_selection_manager.dragbox_hide()
		else:
			# Single Selection Method
			update_player_selection([])
			var mouse_position: Vector2 = obj_rts_camera.get_global_mouse_position()
			var access_key = Scripts.PREFAB_LIST.UNIT_WOKER
			var access_position = Scripts.OBJDATA.TILEMAPLAYERS
			var layer = Scripts.DATABASE.DATABASE_UNITS[Scripts.PREFAB_LIST.UNIT_WOKER][Scripts.OBJDATA.TILEMAPLAYERS]
			var mouse_cell: Vector2i = Scripts.TILE_MANAGER.get_tile_location(layer, mouse_position)
			var scan_cell = obj_map_manager.get_neighboors(mouse_cell)
			var coordinates = Scripts.DATABASE.DATABASE_UNITS[ Scripts.PREFAB_LIST.UNIT_WOKER][Scripts.OBJDATA.TILE_POSIITONS]
			for cell in scan_cell:
				if coordinates.has(cell):
					for object:CharacterBody2D in coordinates[cell]:
						if obj_selection_manager.select_object_by_sprite(
							object,
							get_viewport().get_camera_2d()):
								update_player_selection([object])
								break
						
	if Input.is_action_just_released(&"input_action_mouseclick_right"):
		if _player_selection.size() > 0:
			var mouse_position = obj_rts_camera.get_global_mouse_position()
			var resource_found = return_object_that_intersect_mouse(mouse_position)
			if resource_found.size():
				# found Resource obj
				for unit: CharacterBody2D in _player_selection:
					Scripts.RTS_WORLD.new_path(unit, mouse_position)
					var coordinates =  Scripts.DATABASE.DATABASE_RESOURCES[Scripts.PREFAB_LIST.RESOURCE_TREE][Scripts.OBJDATA.TILE_POSIITONS]
					Scripts.DATA_MANAGER.set_data_value(unit, Scripts.OBJDATA.OBJ_TARGET, resource_found.keys()[0])
			else:
				# Move Units to Mouse Position
				move_units_to_mouse()
				
func return_object_that_intersect_mouse(mouse_position: Vector2) -> Dictionary:
	var layer = Scripts.DATABASE.DATABASE_RESOURCES[Scripts.PREFAB_LIST.RESOURCE_TREE][Scripts.OBJDATA.TILEMAPLAYERS]
	var coordinates =  Scripts.DATABASE.DATABASE_RESOURCES[Scripts.PREFAB_LIST.RESOURCE_TREE][Scripts.OBJDATA.TILE_POSIITONS]
	var mouse_cell: Vector2i = Scripts.TILE_MANAGER.get_tile_location(layer, mouse_position)
	const TREE_SCENE = preload("res://rts_systems/rts_objects/resources/tree.tscn")
	var tree = TREE_SCENE.instantiate()
	Scripts.DATA_MANAGER.set_data_value(tree, Scripts.OBJDATA.RTS_OBJ_TYPE, Scripts.PREFAB_LIST.RESOURCE_TREE)
	# Scripts.OBJDATA.RESOUCE_AMOUNT
	var amount = Scripts.DATABASE.DATABASE_RESOURCES[Scripts.PREFAB_LIST.RESOURCE_TREE][Scripts.OBJDATA.RESOUCE_AMOUNT]
	Scripts.DATA_MANAGER.set_data_value(tree, Scripts.OBJDATA.RESOUCE_AMOUNT, amount)
	Scripts.DATA_MANAGER.set_data_value(tree, Scripts.OBJDATA.TILE_POSIITONS, mouse_cell)
	Scripts.DATA_MANAGER.set_data_value(tree, Scripts.OBJDATA.OBJ_STATE, Scripts.STATE_LIST.IDLE)
	if coordinates.has(mouse_cell):
		coordinates[mouse_cell].clear()
		layer.register_object(mouse_cell, tree)
		return {tree: mouse_cell}
	tree.free()
	return {}
	
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
