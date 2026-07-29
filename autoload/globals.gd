extends Node2D
# meta default

## enums
## const
## public vars
var debug_lines = []
## private vars
## onready vars
# obj_ for node references
## export vars
@export var line_scene: PackedScene
## built-in overide methods

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	top_level = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
## public methods
func create_debug_lines_at(
	path: PackedVector2Array,
	color: Color
):

	for i in range(path.size()-1):
		create_line(path[i], path[i + 1])


func clear_debug_lines():
	for line in debug_lines:
		line.queue_free()

	debug_lines.clear()
	
func create_line(a: Vector2, b: Vector2):
	var line := Line2D.new()
	line.add_point(a)
	line.add_point(b)

	line.width = 2.5
	line.default_color = Color.RED
	line.z_index = 1000
	add_child(line)
	debug_lines.append(line)
## private methods
