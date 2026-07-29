extends Node2D
# meta default

## enums
## const
const CAMERA_PAN_MARGIN: float = 5.0
const CAMERA_ZOOM_SPEED: float = 4.0

## public vars
var cam_movement_velocity: Vector2 = Vector2.ZERO
var cam_zoom_velocity: float = 0.0
## private vars
## onready vars
## built-in overide methods
@onready var obj_camera: Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_apply_movement_velocity()
	
## public methods
func camera_pan(mouse_pos: Vector2, viewport_size: Vector2, detla: float) -> void:
	cam_movement_velocity = Vector2.ZERO
	if mouse_pos.x < CAMERA_PAN_MARGIN:
		cam_movement_velocity.x += -1 * detla
	elif mouse_pos.x > viewport_size.x - CAMERA_PAN_MARGIN:
		cam_movement_velocity.x += 1 * detla

	if mouse_pos.y < CAMERA_PAN_MARGIN:
		cam_movement_velocity.y += -1 * detla
	elif mouse_pos.y > viewport_size.y - CAMERA_PAN_MARGIN:
		cam_movement_velocity.y += 1 * detla

		
## private methods
func _apply_movement_velocity() -> void:
	if cam_movement_velocity != Vector2.ZERO:
		translate(cam_movement_velocity * 200)
