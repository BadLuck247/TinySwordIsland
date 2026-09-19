extends RefCounted
# meta default

## enums
## const
const ACTION_SCRIPTS: Dictionary[int, Script] = {
	Scripts.ACTION_IDS.ACTION_MOVE : preload("res://rts_scripts/obj_actions/action_move.gd"),
	Scripts.ACTION_IDS.ACTION_SELECTABLE: preload("res://rts_scripts/obj_actions/action_selectable.gd"),
	Scripts.ACTION_IDS.ACTION_GATHER: preload("res://rts_scripts/obj_actions/action_gather.gd") 
}
## public vars
## private vars
## onready vars
# obj_ for node references
## built-in overide methods	
## public methods
static func initialize_action(obj_caller: Node) -> void:
	var obj_action_ids: Array = Scripts.PREFAB_MANAGER.prefab_fetch_key_value(obj_caller, Scripts.OBJDATA.OBJ_ACTION_IDS)
	for action: Script in Scripts.ACTION_MANAGER.get_action_script_array_from_action_ids(obj_action_ids):
		action.initialize_action(obj_caller)
		
static func get_action_script_array_from_action_ids(action_ids: Array) -> Array[Script]:
	var script_array: Array[Script]
	for action_id: int in ACTION_SCRIPTS.keys():
		if action_id in action_ids:
			script_array.append(ACTION_SCRIPTS[action_id])
	return script_array
## private methods
