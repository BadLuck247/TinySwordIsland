extends TileMapLayer
# meta default

## enums
## const
## public vars
var unit_on_tiles:  Dictionary = {}
var enemy_on_tiles: Dictionary = {}
var nearest_enemies = []
## private vars
## onready vars
# obj_ for node references
## built-in overide methods

# Called when the node enters the scene tree for the first time.

func _ready():
	await get_tree().process_frame
	for unit in get_tree().get_nodes_in_group("units"):
		unit.RELOCATE.connect(_on_relocate_units)
		var local_pos = to_local(unit.position)
		var map_pos = local_to_map(local_pos)
		register_object(map_pos, unit, unit_on_tiles)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
## public methods
func register_object(tile_pos: Vector2i, unit: Node2D, object_on_tiles: Dictionary):
	if not object_on_tiles.has(tile_pos):
		object_on_tiles[tile_pos] = []

	object_on_tiles[tile_pos].append(unit)
	
func unregister_unit(tile_pos: Vector2i, unit: Node2D,  object_on_tiles: Dictionary):
	if not object_on_tiles.has(tile_pos):
		return

	object_on_tiles[tile_pos].erase(unit)
	
	if object_on_tiles[tile_pos].is_empty():
		object_on_tiles.erase(tile_pos)
		
## private methods
func _on_relocate_units(position: Vector2, body: CharacterBody2D) -> void:
	var map_pos: Vector2i = local_to_map(position)
	if unit_on_tiles.has(position):
		return
	for objects in unit_on_tiles.values():
		if objects.has(body):
			objects.erase(body)
	register_object(map_pos, body, unit_on_tiles)
	
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
