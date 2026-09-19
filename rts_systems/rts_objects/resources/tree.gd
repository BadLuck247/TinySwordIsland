extends CharacterBody2D
# meta default

## enums
## const
# Aliases
static var OBJ_PREFAB_DATA: Dictionary = Scripts.DATABASE.DATABASE_RESOURCES[
	Scripts.PREFAB_LIST.RESOURCE_TREE]
## public vars
var obj_data: Dictionary = {}
## private vars
## onready vars
## built-in overide methods
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Scripts.ACTION_MANAGER.initialize_action(self)
	Scripts.PREFAB_INITIALIZER.initialize_prefab_on_object(self, OBJ_PREFAB_DATA)

func _physics_process(delta) -> void:
	Scripts.STATE_MANAGER.execute_state(self, delta)
