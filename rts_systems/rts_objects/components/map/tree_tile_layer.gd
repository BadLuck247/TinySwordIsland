extends TileMapLayer
# meta default

## enums
## const
## public vars
var trees: Array[Vector2i] = []
## private vars
## onready vars
# obj_ for node references
## built-in overide methods


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	trees = get_used_cells()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
## public methods
func get_tile_location(object_position: Vector2) -> Vector2i:
	var local_position: Vector2 = to_local(object_position)
	var cell: Vector2i = local_to_map(local_position)
	return cell
## private methods
