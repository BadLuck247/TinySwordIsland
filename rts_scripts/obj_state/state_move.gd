extends RefCounted
# meta default

## enums
## const
const __ACT_NAMES = preload("res://rts_scripts/obj_actions/constants.gd").ACTION_LIST
# Aliases
## public vars
## private vars
## onready vars
# obj_ for node references
## built-in overide methods
## public methods
static func enter_state(obj_caller: Node) -> void:
	Scripts.DATA_MANAGER.set_data_value(
		obj_caller, Scripts.OBJDATA.OBJ_STATE, Scripts.STATE_LIST.MOVE)
		
static func execute_state(obj_caller: Node, delta: float) -> void:
	if (Scripts.DATA_MANAGER.get_data_value(
		obj_caller,
		Scripts.OBJDATA.OBJ_PATH) as PackedVector2Array).size() > 1:
			Scripts.ACTIONS[__ACT_NAMES.ACTION_MOVE].path_follow(obj_caller, delta)
	else:
		# Go back to idle if no path	
		# Collect a resource if the worker is in gather state
		if Scripts.RTS_WORLD.obj_has_action_id(obj_caller, Scripts.ACTION_IDS.ACTION_GATHER):
			var target_resource: Node = Scripts.DATA_MANAGER.get_data_value(obj_caller, Scripts.OBJDATA.OBJ_TARGET)
			if target_resource != obj_caller:
				if Scripts.RTS_WORLD.obj_is_rts_type(target_resource, Scripts.PREFAB_LIST.RESOURCE_TREE):
					Scripts.STATE_MANAGER.change_state(obj_caller, Scripts.STATE_LIST.GATHER)
					return # Exit function 
					
		Scripts.STATE_MANAGER.change_state(obj_caller, Scripts.STATE_LIST.IDLE)
	
static func exit_state(obj_caller: Node) -> void:
	pass
	
static func execute_signal(obj_caller: Node, signal_int: int) -> void:
	pass
## private methods
