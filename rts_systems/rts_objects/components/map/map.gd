extends Node
# meta default

## enums
## const

# const SCRIPT_GROUND_TILE_LAYER: Script = preload("res://rts_systems/rts_objects/components/map/ground_tile_layer.gd")

## public vars
var current_hovered_tile := Vector2i(-1, -1)
var selector_instance: Sprite2D
var tree_instance: CharacterBody2D
## private vars
## onready vars
# obj_ for node references
@onready var obj_rts_camera: Node2D = $"../../RtsCamera"
## export vars
@export var selector: PackedScene
@export var tree: PackedScene
## built-in overide methods

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_object_selector()
	
## public methods	
func get_neighboors(cell_position: Vector2i) -> Array:
	var radius = 1
	# Check the 9 neighboring tiles
	var neighbors: Array[Vector2i] = [cell_position]
	for dx in range(-radius,radius+1):
		for dy in range(-radius, radius+1):

			if dx == 0 and dy == 0:
				continue
			var neighbor = cell_position + Vector2i(dx, dy)
			neighbors.append(neighbor)
	return neighbors
	
func update_object_selector() -> void:
	if get_tree().get_nodes_in_group("selected-units").size() > 0:
		var mouse_position: Vector2 = obj_rts_camera.get_global_mouse_position()
		#var mouse_cell: Vector2i = obj_tree_map_layer.get_tile_location(mouse_position)
#
		## Only update when the tile changes
		#if mouse_cell != current_hovered_tile:
			#current_hovered_tile = mouse_cell
#
			#if get_trees().has(mouse_cell):
				#spawn_selector(mouse_cell)
			#else:
				#remove_selector()

func spawn_selector(cell: Vector2i):
	if selector_instance == null:
		selector_instance = selector.instantiate()
		add_child(selector_instance)

	if tree_instance == null:
		tree_instance = tree.instantiate()
		add_child(tree_instance)
		tree_instance.hide()
		tree_instance.add_to_group("selected-object")

	#var tile_world_position = obj_tree_map_layer.map_to_local(cell)
	#var global_position = obj_tree_map_layer.to_global(tile_world_position)
#
	#selector_instance.global_position = global_position
	#tree_instance.global_position = global_position


func remove_selector():
	if selector_instance:
		selector_instance.queue_free()
		selector_instance = null

	if tree_instance:
		tree_instance.remove_from_group("selected-object")
		tree_instance.queue_free()
		tree_instance = null
## private methods


	
