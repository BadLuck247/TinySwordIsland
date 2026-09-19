extends Node
# meta default

## enums
## const
const DRAGBOX_MIN_SIZE: int = 4 # Area values not pixels
## public vars
## private vars
## onready vars
## built-in overide methods
@onready var obj_ui_dragbox: NinePatchRect = $NinePatchRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dragbox_hide()

## public methods
func dragbox_select_objects(object_lists: Array, dragbox_rect: Rect2) -> void:
	for object: CharacterBody2D in (object_lists as Array[CharacterBody2D]):
		var position_in_2d: Vector2 = get_viewport().get_canvas_transform() * object.global_position
		if dragbox_rect.has_point(position_in_2d):
			select_obj(object)
		else:
			deselect_obj(object)

func get_dragbox_select_objects(object_lists: Array, dragbox_rect: Rect2) -> Array[CharacterBody2D]:
	var selected_array: Array[CharacterBody2D] = []
	for object: CharacterBody2D in (object_lists as Array[CharacterBody2D]):
		if dragbox_rect.has_point(object.global_position):
			select_obj(object)
			selected_array.append(object)
	return selected_array

func update_selection_rectangle(new_rect: Rect2) -> void:
	new_rect = new_rect.abs()
	obj_ui_dragbox.position = new_rect.position
	obj_ui_dragbox.size = new_rect.size
	if new_rect.get_area() > DRAGBOX_MIN_SIZE:
		obj_ui_dragbox.show()
		
func select_array(array: Array[CharacterBody2D]) -> void:
	for object in array: 
		select_obj(object)
	
func deselect_array(array: Array[CharacterBody2D]) -> void:
	for object in array: 
		deselect_obj(object)
		
func select_object_by_sprite(object: CharacterBody2D, camera: Camera2D) -> bool:
	var mouse_world_position := camera.get_global_mouse_position()
	var rect := Rect2(-32, -32, 64, 64)
	var sprite_rect := Rect2(
		object.global_position + rect.position,
		rect.size
	)

	return sprite_rect.has_point(mouse_world_position)

func dragbox_show() -> void:
	obj_ui_dragbox.show()
	
func dragbox_hide() -> void:
	obj_ui_dragbox.hide()

func select_obj(object: Node) -> void:
	Scripts.ACTIONS[Scripts.ACTION_IDS.ACTION_SELECTABLE].select_obj(object)
	
func deselect_obj(object: Node) -> void:
	Scripts.ACTIONS[Scripts.ACTION_IDS.ACTION_SELECTABLE].deselect_obj(object)
	
func toggle_select_obj(object: Node) -> void:
	Scripts.ACTIONS[Scripts.ACTION_IDS.ACTION_SELECTABLE].toggle_select_obj(object)
	

## private methods
