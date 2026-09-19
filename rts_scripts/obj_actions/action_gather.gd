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
static func initialize_action(caller: Node) -> void:
	Scripts.DATA_MANAGER.set_data_value(caller, Scripts.OBJDATA.OBJ_TARGET, caller)
## private methods
