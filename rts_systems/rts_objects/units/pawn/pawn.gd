extends CharacterBody2D
# meta default

## enums
## const
const SCRIPT_ACTS_MANAGER = preload("res://rts_scripts/obj_actions/main_manager.gd")
const SCRIPT_ACTS_CONST = preload("res://rts_scripts/obj_actions/constants.gd")
const SCRIPT_DATA_MANAGER = preload("res://rts_scripts/obj_data/main_manager.gd")
const SCRIPT_DATA_CONST = preload("res://rts_scripts/obj_data/constants.gd")
const OBJ_ACTIONS: Array[Script] = [
	__ACTS_SCRIPT[__ACTS_CONST.ACTION_MOVE],
	__ACTS_SCRIPT[__ACTS_CONST.ACTION_SELECTABLE]
]
# Aliases
const __ACTS_CONST = SCRIPT_ACTS_CONST.ACTION_NAMES
const __ACTS_SCRIPT = SCRIPT_ACTS_MANAGER.ACTION_SCRIPTS
const __DATA_LIST = SCRIPT_DATA_CONST.DATA_LIST
## public vars
var obj_data: Dictionary = {}
## private vars
## onready vars
## built-in overide methods
## signals
signal RELOCATE(position: Vector2, body: CharacterBody2D)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_start_up()
	add_to_group("units")
	
func _physics_process(delta) -> void:
	if velocity == Vector2.ZERO:
		RELOCATE.emit(position, self)
	OBJ_ACTIONS[0].call_on_physics_tick(self, delta)
	
 ## public methods
func new_path(where_to: Vector2) -> void:
	__ACTS_SCRIPT[__ACTS_CONST.ACTION_MOVE].path_new(self, where_to)	
			
func select_obj() -> void:
	OBJ_ACTIONS[1].select_obj(self)
	
func deselect_obj() -> void:
	OBJ_ACTIONS[1].deselect_obj(self)
	
func toggle_select_obj() -> void:
	OBJ_ACTIONS[1].toggle_select_obj(self)
## private methods
func _start_up() -> void:
	SCRIPT_DATA_MANAGER.set_data_value(self, __DATA_LIST.MOVE_SPEED, 350)
	SCRIPT_ACTS_MANAGER.initialize_actions(self, OBJ_ACTIONS)
