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
static func initialize_prefab_on_object(obj_to_initialize: Node, prefab_data_dict: Dictionary) -> void:
	process_object_actions(obj_to_initialize)
	(obj_to_initialize.obj_data as Dictionary).merge(prefab_data_dict, true)
		
static func process_object_actions(obj_to_initialize: Node) -> void:
	# Object has OBJ_ACTION_IDS to be initialize
	if Scripts.PREFAB_MANAGER.prefab_fetch_key_value(obj_to_initialize, Scripts.OBJDATA.OBJ_ACTION_IDS):
		# Does this object has an action that requires a Cycler Timers? eg: (gather, repair)
		const ACTION_THAT_NEEDS_CYCLER_TIMER = [
			Scripts.ACTION_IDS.ACTION_GATHER,]
		
		var obj_action_ids: Array = Scripts.PREFAB_MANAGER.prefab_fetch_key_value(
			obj_to_initialize, Scripts.OBJDATA.OBJ_ACTION_IDS)
			
		for obj_action_id:int in obj_action_ids:
			if obj_action_id in ACTION_THAT_NEEDS_CYCLER_TIMER:
				add_cycler_timer(obj_to_initialize)
				break #found an action that needs a cycler timer
		
static func add_cycler_timer(obj_caller: Node) -> void:
	if !Scripts.DATA_MANAGER.has_data_key(obj_caller, Scripts.OBJDATA.OBJ_ACTION_CYCLE_TIMER_TIMER):
		var new_timer: Timer = Timer.new()
		new_timer.timeout.connect(
				func() -> void: 
					Scripts.STATE_MANAGER.execute_signal(obj_caller, 
						Scripts.STATE_SIGNALS.OBJ_ACTION_CYCLE_TIMER_TIMEOUT))
		obj_caller.add_child(new_timer)
		Scripts.DATA_MANAGER.set_data_value(obj_caller, Scripts.OBJDATA.OBJ_ACTION_CYCLE_TIMER_TIMER, new_timer)
		
## private methods
