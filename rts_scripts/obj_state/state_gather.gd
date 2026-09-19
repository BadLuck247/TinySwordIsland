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
	Scripts.DATA_MANAGER.set_data_value(obj_caller, Scripts.OBJDATA.OBJ_STATE, Scripts.STATE_LIST.GATHER)
	var current = Scripts.DATA_MANAGER.get_data_value(obj_caller, Scripts.OBJDATA.OBJ_ACTION_CYCLE_TIMER_TIMER)
	var cycle_timer: Timer = Scripts.DATA_MANAGER.get_data_value(obj_caller, Scripts.OBJDATA.OBJ_ACTION_CYCLE_TIMER_TIMER)
	cycle_timer.start(1) # Start counting to gather with state_signal OBJ_ACTION_CYCLE_TIMER_TIMOUT
	
static func execute_state(obj_caller: Node, delta: float) -> void:
	var target_resouce: Node = Scripts.DATA_MANAGER.get_data_value(obj_caller, Scripts.OBJDATA.OBJ_TARGET)
	if target_resouce == obj_caller:
		Scripts.STATE_MANAGER.change_state(obj_caller, Scripts.STATES.IDLE)
	
static func exit_state(obj_caller: Node) -> void:
	var cycle_time: Timer = Scripts.DATA_MANAGER.get_data_value(
		obj_caller, Scripts.OBJDATA.OBJ_ACTION_CYCLE_TIMER_TIMER)
	cycle_time.stop() # No more need for cycle timer
	
	# Reset the target object back to self, ak: null
	Scripts.DATA_MANAGER.set_data_value(obj_caller, Scripts.OBJDATA.OBJ_TARGET, obj_caller)
	
static func execute_signal(obj_caller: Node, signal_int: int) -> void:
	var obj_state: int = Scripts.DATA_MANAGER.get_data_value(
		obj_caller,
		Scripts.OBJDATA.OBJ_STATE)

	match [obj_state, signal_int]:
		[Scripts.STATE_LIST.GATHER,  Scripts.STATE_SIGNALS.OBJ_ACTION_CYCLE_TIMER_TIMEOUT]:
			gather(obj_caller)
		
		[Scripts.STATE_LIST.GATHER,  Scripts.STATE_SIGNALS.RESOURCE_IS_EMPTY]:
			Scripts.STATE_MANAGER.change_state(obj_caller, Scripts.STATE_LIST.IDLE)
				
		[Scripts.STATE_LIST.GATHER,  Scripts.STATE_SIGNALS.REQUEST_TO_MOVE]:
			Scripts.STATE_SHARED_FUNCTIONS.request_new_movement(obj_caller)
		
			
static func gather(obj_caller: Node) -> void:
	var target_resource: Object = Scripts.DATA_MANAGER.get_data_value(
		obj_caller,
		Scripts.OBJDATA.OBJ_TARGET
	)

	var gathering_amount: float = (
		Scripts.DATA_MANAGER.get_data_value(
			obj_caller,
			Scripts.OBJDATA.GATHERING_AMOUNT_PER_CYCLE
		) as Dictionary
	)[Scripts.OBJDATA.RESOURCE_WOOD]

	var resource_amount: float = Scripts.DATA_MANAGER.get_data_value(
		target_resource,
		Scripts.OBJDATA.RESOUCE_AMOUNT
	)

	var resource_gathered_amount: float = min(
		gathering_amount,
		resource_amount
	)

	var new_resource_amount: float = max(
		resource_amount - resource_gathered_amount,
		0
	)

	if resource_gathered_amount > 0:
		# Deduct resource from target.
		Scripts.DATA_MANAGER.set_data_value(
			target_resource,
			Scripts.OBJDATA.RESOUCE_AMOUNT,
			new_resource_amount
		)

		# Add gathered resource to the caller's carried resources.
		var current_carried_amount: float = Scripts.DATA_MANAGER.get_data_value(
			obj_caller,
			Scripts.OBJDATA.RESOUCE_AMOUNT
		)

		Scripts.DATA_MANAGER.set_data_value(
			obj_caller,
			Scripts.OBJDATA.RESOUCE_AMOUNT,
			current_carried_amount + resource_gathered_amount
		)

		print(
			obj_caller,
			"> Gather() Resource Gathered: ",
			resource_gathered_amount
		)

	if resource_gathered_amount == 0:
		# No resource is available.
		Scripts.STATE_MANAGER.execute_signal(
			target_resource,
			Scripts.STATE_SIGNALS.RESOURCE_IS_EMPTY
		)
		var tree_cell = Scripts.DATA_MANAGER.get_data_value(target_resource, Scripts.OBJDATA.TILE_POSIITONS)
		var tilemaplayer =  Scripts.DATABASE.DATABASE_RESOURCES[Scripts.PREFAB_LIST.RESOURCE_TREE][Scripts.OBJDATA.TILEMAPLAYERS]
		tilemaplayer.erase_cell(tree_cell)
		execute_signal(
			obj_caller,
			Scripts.STATE_SIGNALS.RESOURCE_IS_EMPTY
		)
		
## private methods
