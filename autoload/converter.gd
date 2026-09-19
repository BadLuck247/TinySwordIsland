extends TileMapLayer
# meta default

## enums
## const
## public vars
## private vars
## onready vars
# obj_ for node references
## built-in overide methods


func get_tile_location(object_position: Vector2) -> Vector2i:
	var local_position: Vector2 = to_local(object_position)
	var cell: Vector2i = local_to_map(local_position)
	return cell

func get_tiles_in_rect(rect: Rect2) -> Array[Vector2i]:
	var start = local_to_map(rect.position)
	var end = local_to_map(rect.end - Vector2.ONE)
	var tiles: Array[Vector2i] = []
	for y in range(start.y, end.y + 1):
		for x in range(start.x, end.x + 1):
			tiles.append(Vector2i(x, y))
	return tiles
	
static func unregister_unit(tile_pos: Vector2i, unit: Node2D,  object_on_tiles: Dictionary):
	if not object_on_tiles.has(tile_pos):
		return

	object_on_tiles[tile_pos].erase(unit)
	
	if object_on_tiles[tile_pos].is_empty():
		object_on_tiles.erase(tile_pos)
