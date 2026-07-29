extends RefCounted
# meta default

## enums
## const
const SCRIPT_DATA_MANAGER = preload("res://rts_scripts/obj_data/main_manager.gd")
const SCRIPT_DATA_CONST = preload("res://rts_scripts/obj_data/constants.gd")
const SCRIPT_ACTS_CONSTS = preload("res://rts_scripts/obj_actions/constants.gd")
# ALIASES
const __DATA_CONSTS = SCRIPT_DATA_CONST.DATA_LIST
## public vars
## private vars
## onready vars
# obj_ for node references
## built-in overide methods


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
## public methods
static func initialize_action(caller: Node2D) -> void:
	SCRIPT_DATA_MANAGER.add_data_value(caller, __DATA_CONSTS.OBJ_PATH, PackedVector2Array())
	SCRIPT_DATA_MANAGER.add_data_value(caller, __DATA_CONSTS.OBJ_PATH_GOAL, Vector2.ZERO)
	SCRIPT_DATA_MANAGER.add_data_value(caller, __DATA_CONSTS.OBJ_CURRENT_PATH_INDEX, 0)

static func call_on_physics_tick(
	caller: Node2D,
	delta: float,
	) -> void:
	if (SCRIPT_DATA_MANAGER.get_data_value(caller, __DATA_CONSTS.OBJ_PATH) as PackedVector2Array).size() > 1:
		path_follow(caller, delta)

static func path_new(
	caller: Node2D,
	path_goal: Vector2,
	) -> void:
	var new_path: PackedVector2Array = NavigationServer2D.map_get_path(
		caller.get_world_2d().get_navigation_map(),
		caller.global_position,
		path_goal,
		true
	)
	SCRIPT_DATA_MANAGER.set_data_value(caller, __DATA_CONSTS.OBJ_PATH, new_path)
	SCRIPT_DATA_MANAGER.set_data_value(caller, __DATA_CONSTS.OBJ_CURRENT_PATH_INDEX, 0)
static func path_follow(
	caller: Node2D,
	delta: float,
	) -> void:
	var path: PackedVector2Array = SCRIPT_DATA_MANAGER.get_data_value(caller, __DATA_CONSTS.OBJ_PATH)
	if path.size() == 0:
		return
		
	var current_path_index: int = SCRIPT_DATA_MANAGER.get_data_value(caller, __DATA_CONSTS.OBJ_CURRENT_PATH_INDEX)
	
	if current_path_index < path.size():
		var target := path[current_path_index]
		var move_speed: float = SCRIPT_DATA_MANAGER.get_data_value(caller, __DATA_CONSTS.MOVE_SPEED)

		var to_target := target - caller.global_position
		var distance := to_target.length()
		var step := move_speed * delta

		if step >= distance:
			caller.global_position = target
			SCRIPT_DATA_MANAGER.set_data_value(
				caller,
				__DATA_CONSTS.OBJ_CURRENT_PATH_INDEX,
				current_path_index + 1
			)
		else:
			caller.global_position += to_target.normalized() * step
			
	elif current_path_index >= path.size():
		SCRIPT_DATA_MANAGER.set_data_value(caller, __DATA_CONSTS.OBJ_PATH, PackedVector2Array())
		SCRIPT_DATA_MANAGER.set_data_value(caller, __DATA_CONSTS.OBJ_CURRENT_PATH_INDEX, 0)
## private methods
