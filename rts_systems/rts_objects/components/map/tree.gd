extends TileMapLayer
# meta default

## enums
enum ASSET {UNIT, TREE}
## const
# Aliases
## public vars
## private vars
## onready vars
## built-in overide methods
# Called when the node enters the scene tree for the first time.
## const
## public
## built-in override methods
func _ready() -> void:
	await get_tree().process_frame
	Scripts.DATABASE.DATABASE_RESOURCES[Scripts.PREFAB_LIST.RESOURCE_TREE][Scripts.OBJDATA.TILEMAPLAYERS] = self
	for cell in get_used_cells():
		register_object(cell, null)


func get_tile_location(object_position: Vector2) -> Vector2i:
	return Scripts.TILE_MANAGER.get_tile_location(
		self, object_position
	)

func register_object(tile_pos: Vector2i, unit: Node2D):
	var access_database = Scripts.DATABASE.DATABASE_RESOURCES
	var access_key = Scripts.PREFAB_LIST.RESOURCE_TREE
	var access_position = Scripts.OBJDATA.TILE_POSIITONS
	var object_on_tiles = access_database[access_key][access_position]
	Scripts.TILE_MANAGER.register_object(
			tile_pos,
			unit,
			object_on_tiles
	)
