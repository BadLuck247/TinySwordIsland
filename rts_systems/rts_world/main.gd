extends Node
# meta default

## enums
## const
## public vars
## private vars
## onready vars
# obj_ for node references
## built-in overide methods
## public methods
## public methods
static func obj_has_data(rts_object: Node) -> bool:
	if rts_object.get("obj_data"):
		return true
	return false
	
static func obj_is_rts_type(rts_object: Node, rts_type: int) -> bool:
	if (Scripts.RTS_WORLD.obj_has_data(rts_object) and 
		Scripts.DATA_MANAGER.get_data_value(rts_object, Scripts.OBJDATA.RTS_OBJ_TYPE) == rts_type):
		return true
	return false
	
static func obj_has_action_id(rts_object: Node, action_id: int) -> bool:
	if (Scripts.PREFAB_MANAGER.prefab_fetch_key_value(
		rts_object, Scripts.OBJDATA.OBJ_ACTION_IDS) as Array).has(action_id):
		return true
	return false

static func new_path(obj_caller: Node, where_to: Vector2) -> void:
	Scripts.DATA_MANAGER.set_data_value(obj_caller, Scripts.OBJDATA.OBJ_NEW_PATH_GOAL, where_to)
	Scripts.STATE_MANAGER.execute_signal(obj_caller, Scripts.STATE_SIGNALS.REQUEST_TO_MOVE)
## private methods
