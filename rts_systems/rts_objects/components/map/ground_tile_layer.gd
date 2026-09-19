extends TileMapLayer

## const
## public
## built-in override methods
func _ready() -> void:
	await get_tree().process_frame
	var access_database = Scripts.DATABASE.DATABASE_UNITS
	var access_key = Scripts.PREFAB_LIST.UNIT_WOKER
	var access_layer = Scripts.OBJDATA.TILEMAPLAYERS
	access_database[access_key][access_layer] = self
	for unit in get_tree().get_nodes_in_group("units"):
		var tile_pos := get_tile_location(unit.position)
		register_object(tile_pos, unit)

func get_tile_location(object_position: Vector2) -> Vector2i:
	return Scripts.TILE_MANAGER.get_tile_location(
		self, object_position
	)

func register_object(tile_pos: Vector2i, unit: Node2D):
	var object_on_tiles = Scripts.DATABASE.DATABASE_UNITS[
		Scripts.PREFAB_LIST.UNIT_WOKER
	][
		Scripts.OBJDATA.TILE_POSIITONS
	]
	Scripts.TILE_MANAGER.register_object(
			tile_pos,
			unit,
			object_on_tiles
	)

func unregister_object(tile_pos: Vector2i, unit: Node2D):
	var object_on_tiles = Scripts.DATABASE.DATABASE_UNITS[
		Scripts.PREFAB_LIST.UNIT_WOKER
	][
		Scripts.OBJDATA.TILE_POSIITONS
	]
	Scripts.TILE_MANAGER.unregister_object(
			tile_pos,
			unit,
			object_on_tiles
	)
