extends Node
# meta default

## enums
## const
## public vars
## private vars
## onready vars
## built-in overide methods
@onready var rts_camera: Node2D = $RtsWorld/RtsCamera


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_released(&"input_action_enter") or \
		Input.is_action_just_released("input_action_mouseclick_left"):
		get_viewport().set_input_as_handled()
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	
	if Input.is_action_just_released(&"input_action_esc"):
		get_viewport().set_input_as_handled()
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CONFINED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			get_tree().quit()
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
## public methods

## private methods
