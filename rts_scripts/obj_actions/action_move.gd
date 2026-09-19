extends RefCounted
# meta default

## enums
## const
# ALIASES
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
static func initialize_action(caller: Node) -> void:
	Scripts.DATA_MANAGER.add_data_value(caller, Scripts.OBJDATA.OBJ_PATH, PackedVector2Array())
	Scripts.DATA_MANAGER.add_data_value(caller, Scripts.OBJDATA.OBJ_NEW_PATH_GOAL, Vector2.ZERO)
	Scripts.DATA_MANAGER.add_data_value(caller, Scripts.OBJDATA.OBJ_CURRENT_PATH_INDEX, 1)

#static func call_on_physics_tick(
	#caller: Node2D,
	#delta: float,
	#) -> void:
	#if (Scripts.DATA_MANAGER.get_data_value(caller, Script.OBJDATA.OBJ_PATH) as PackedVector2Array).size() > 1:
		#path_follow(caller, delta)

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
	Scripts.DATA_MANAGER.set_data_value(caller, Scripts.OBJDATA.OBJ_PATH, new_path)
	Scripts.DATA_MANAGER.set_data_value(caller, Scripts.OBJDATA.OBJ_CURRENT_PATH_INDEX, 1)
	
static func path_follow(
	caller: Node2D,
	delta: float,
	) -> void:
	var path: PackedVector2Array = Scripts.DATA_MANAGER.get_data_value(caller, Scripts.OBJDATA.OBJ_PATH)
	if path.size() == 0:
		return
		
	var current_path_index: int = Scripts.DATA_MANAGER.get_data_value(caller, Scripts.OBJDATA.OBJ_CURRENT_PATH_INDEX)
	
	if current_path_index < path.size():
		var target := path[current_path_index]
		var move_speed: float = Scripts.DATA_MANAGER.get_data_value(caller, Scripts.OBJDATA.MOVE_SPEED)

		var to_target := target - caller.global_position
		var distance := to_target.length()
		var step := move_speed * delta

		if step >= distance:
			caller.global_position = target
			Scripts.DATA_MANAGER.set_data_value(
				caller,
				Scripts.OBJDATA.OBJ_CURRENT_PATH_INDEX,
				current_path_index + 1
			)
		else:
			caller.global_position += to_target.normalized() * step
			
	elif current_path_index >= path.size():
		Scripts.DATA_MANAGER.set_data_value(caller, Scripts.OBJDATA.OBJ_PATH, PackedVector2Array())
		Scripts.DATA_MANAGER.set_data_value(caller, Scripts.OBJDATA.OBJ_CURRENT_PATH_INDEX, 0)
## private methods
