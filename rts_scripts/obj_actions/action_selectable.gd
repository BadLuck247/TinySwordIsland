extends RefCounted
# meta default

## enums
## const
const SPRITE_SELECTOR = preload("res://rts_systems/rts_objects/components/selector/selector.tscn")
# ALIASES

## public vars
## private vars
## onready vars
# obj_ for node references
## built-in overide methods
## public methods
static func initialize_action(caller: Node) -> void:
	Scripts.DATA_MANAGER.set_data_value(caller, Scripts.OBJDATA.OBJ_SELECTED, false)
	var sprite_copy = SPRITE_SELECTOR.instantiate()
	caller.add_child(sprite_copy)
	sprite_copy.global_position = caller.global_position
	Scripts.DATA_MANAGER.set_data_value(caller, Scripts.OBJDATA.OBJ_SELECTED_SPRITE, sprite_copy)
	deselect_obj(caller)
	
static func select_obj(obj_caller: Node) -> void:
	_set_obj_selected_to(obj_caller, true)
	
static func deselect_obj(obj_caller: Node) -> void:
	_set_obj_selected_to(obj_caller, false)
	
static func toggle_select_obj(obj_caller: Node) -> void:
	_set_obj_selected_to(obj_caller, 
		!Scripts.DATA_MANAGER.get_data_value(obj_caller, Scripts.OBJDATA.OBJ_SELECTED)
		)
		
## private methods
static func _set_obj_selected_to(obj: Node2D, set_selected_to: bool) -> void:
	Scripts.DATA_MANAGER.set_data_value(obj, Scripts.OBJDATA.OBJ_SELECTED, set_selected_to)
	var object_selection_sprite: Sprite2D = (Scripts.DATA_MANAGER.get_data_value(obj, Scripts.OBJDATA.OBJ_SELECTED_SPRITE) as Sprite2D)
	object_selection_sprite.visible = set_selected_to
