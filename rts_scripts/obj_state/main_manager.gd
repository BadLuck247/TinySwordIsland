extends RefCounted
# meta default

## enums
## const
const SCRIPT_DATA_MANAGER = preload("res://rts_scripts/obj_data/main_manager.gd")
# Aliases
const __OBJDATA = preload("res://rts_scripts/obj_data/constants.gd").DATA_LIST
const __STATES = preload("res://rts_scripts/obj_state/constants.gd").STATE_LIST
# States
const STATE_SCRIPTS: Dictionary[int, Script] = {
	__STATES.IDLE: preload("res://rts_scripts/obj_state/state_idle.gd"),
	__STATES.MOVING: preload("res://rts_scripts/obj_state/state_move.gd")
}
## public vars
## private vars
## onready vars
# obj_ for node references
## built-in overide methods
## public methods
static func change_state(obj_caller: Node, next_state: int) -> void:
	var obj_state: int = SCRIPT_DATA_MANAGER.get_data_value(obj_caller, __OBJDATA.OBJ_STATE)
	# exit_state(obj_caller, obj_state)
	# enter_state(obj_caller, obj_state)
	
static func enter_state(obj_caller: Node, state: int) -> void:
	# Everything that needs to happen in order to cleanly start the state
	STATE_SCRIPTS[state].enter_state(obj_caller)

static func execute_state(obj_caller: Node, delta: float) -> void:
	# -> Exit from old state
	# Enter new one ->
	var state: int = SCRIPT_DATA_MANAGER.get_data_value(obj_caller, __OBJDATA.OBJ_STATE)
	STATE_SCRIPTS[state].execute_state(obj_caller, delta)
	
static func exit_state(obj_caller: Node, state: int) -> void:
	# Everything that needs to be cleaned after the state ends
	STATE_SCRIPTS[state].exit_state(obj_caller)
	
static func execute_signal(obj_caller: Node, signal_int: int) -> void:
	var obj_state: int = SCRIPT_DATA_MANAGER.get_data_value(
		obj_caller,
		__OBJDATA.OBJ_STATE
	)
	STATE_SCRIPTS[obj_state].execute_signal(obj_caller, signal_int)
## private methods
