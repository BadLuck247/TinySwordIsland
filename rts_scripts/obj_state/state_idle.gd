extends RefCounted
# meta default

## enums
## const
## public vars
## private vars
## onready vars
# obj_ for node references
## built-in overide methods
## public methods
static func enter_state(obj_caller: Node) -> void:
	Scripts.DATA_MANAGER.set_data_value(obj_caller, Scripts.OBJDATA.OBJ_STATE, Scripts.STATE_LIST.IDLE)
	# print(Scripts.DATA_MANAGER.get_data_value(obj_caller, Scripts.OBJDATA.OBJ_STATE))
		
static func execute_state(obj_caller: Node, delta: float) -> void:
	pass
	
static func exit_state(obj_caller: Node) -> void:
	pass
	
static func execute_signal(obj_caller: Node, signal_int: int) -> void:
	var obj_state: int = Scripts.DATA_MANAGER.get_data_value(
		obj_caller,
		Scripts.OBJDATA.OBJ_STATE)
	
	match [obj_state, signal_int]:
		[Scripts.STATE_LIST.IDLE,  Scripts.STATE_SIGNALS.REQUEST_TO_MOVE]:
			var new_path_goal: Vector2 = Scripts.DATA_MANAGER.get_data_value(
				obj_caller, Scripts.OBJDATA.OBJ_NEW_PATH_GOAL)
				
			if new_path_goal != Vector2.ZERO:
				Scripts.ACTIONS[Scripts.ACTION_IDS.ACTION_MOVE].path_new(obj_caller, new_path_goal)
				Scripts.STATE_MANAGER.change_state(obj_caller, Scripts.STATE_LIST.MOVE)
				Scripts.DATA_MANAGER.set_data_value(obj_caller, Scripts.OBJDATA.OBJ_NEW_PATH_GOAL, Vector2.ZERO)
				
		[Scripts.STATE_LIST.IDLE,  Scripts.STATE_SIGNALS.RESOURCE_IS_EMPTY]:
			if Scripts.RTS_WORLD.obj_is_rts_type(obj_caller, Scripts.OBJDATA.RTS_RESOURCE):
				obj_caller.queue_free()
## private methods
