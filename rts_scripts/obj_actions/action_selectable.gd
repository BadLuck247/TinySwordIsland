extends RefCounted
# meta default

## enums
## const
const SCRIPT_DATA_MANAGER = preload("res://rts_scripts/obj_data/main_manager.gd")
const SCRIPT_DATA_CONST = preload("res://rts_scripts/obj_data/constants.gd")
const SPRITE_SELECTOR = preload("res://rts_systems/rts_objects/components/selector/selector.tscn")
# ALIASES
const __DATA_CONST = SCRIPT_DATA_CONST.DATA_LIST
## public vars
## private vars
## onready vars
# obj_ for node references
## built-in overide methods


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
## public methods
static func initialize_action(caller: Node2D) -> void:
	SCRIPT_DATA_MANAGER.set_data_value(caller, __DATA_CONST.OBJ_SELECTED, false)
	var sprite_copy = SPRITE_SELECTOR.instantiate()
	caller.add_child(sprite_copy)
	sprite_copy.global_position = caller.global_position
	SCRIPT_DATA_MANAGER.set_data_value(caller, __DATA_CONST.OBJ_SELECTED_SPRITE, sprite_copy)
	deselect_obj(caller)
	
static func select_obj(obj_caller: Node2D) -> void:
	_set_obj_selected_to(obj_caller, true)
	
static func deselect_obj(obj_caller: Node2D) -> void:
	_set_obj_selected_to(obj_caller, false)
	
static func toggle_select_obj(obj_caller: Node2D) -> void:
	_set_obj_selected_to(obj_caller, 
		!SCRIPT_DATA_MANAGER.get_data_value(obj_caller, __DATA_CONST.OBJ_SELECTED)
		)
		
## private methods
static func _set_obj_selected_to(obj: Node2D, set_selected_to: bool) -> void:
	SCRIPT_DATA_MANAGER.set_data_value(obj, __DATA_CONST.OBJ_SELECTED, set_selected_to)
	var object_selection_sprite: Sprite2D = (SCRIPT_DATA_MANAGER.get_data_value(obj, __DATA_CONST.OBJ_SELECTED_SPRITE) as Sprite2D)
	object_selection_sprite.visible = set_selected_to
