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
## private methods
