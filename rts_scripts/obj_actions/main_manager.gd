extends RefCounted
# meta default

## enums
## const
const SCRIPT_ACTS_CONSTS = preload("res://rts_scripts/obj_actions/constants.gd")
const ACTION_SCRIPTS: Dictionary[int, Script] = {
	SCRIPT_ACTS_CONSTS.ACTION_NAMES.ACTION_MOVE: preload("res://rts_scripts/obj_actions/action_move.gd"),
	SCRIPT_ACTS_CONSTS.ACTION_NAMES.ACTION_SELECTABLE: preload("res://rts_scripts/obj_actions/action_selectable.gd")
}
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
static func initialize_actions(obj_caller: Node, actions: Array[Script]) -> void:
	for action: Script in actions:
		action.initialize_action(obj_caller)
## private methods
