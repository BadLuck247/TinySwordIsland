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
static func prefab_fetch_key_value(from_object: Node, key: int) -> Variant:
	return from_object.OBJ_PREFAB_DATA[key]
## private methods	
