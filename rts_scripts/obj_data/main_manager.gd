extends RefCounted
# meta default

## enums
## const
## public vars
## private vars
## onready vars
# obj_ for node references
## built-in overide methods
## public methods
static func debug_data_dict(obj_caller: Node) -> void:
	print("\n>>DEBUG_PRINT: 'obj_data' from Node'", obj_caller.name, "'")
	var obj_data: Dictionary = get_data_dict(obj_caller)
	for data in obj_data.keys():
		print(Scripts.OBJDATA.keys()[data])
		
static func get_data_dict(from_object: Node) -> Dictionary:
	return from_object.obj_data
	
static func get_data_value(from_object: Node, key: int) -> Variant:
	return from_object.obj_data[key]
	
static func has_data_key(from_object: Node, key: int) -> bool:
	return (from_object.obj_data as Dictionary).has(key)
	
static func set_data_value(from_object: Node, data_key: int, new_data_value: Variant) -> void:
	# Ensure type safety before changing it 
	if has_data_key(from_object, data_key):
		var current_var: Variant = from_object.obj_data[data_key]
		if typeof(current_var) != typeof(new_data_value):
			push_error(
				"\n>>Type mismatch: For set_data_value()! For object: ", from_object.name,
				"\n>>Expected '", current_var, "' but got '", new_data_value, "'.",
				"\n<---> Key Enum Int: ", data_key,
				"\n<---> Old var:", from_object.obj_data[data_key],
				"\n<---> New_var:", new_data_value,
			)
			return # Unexpected change in type
	# Set the data for the obj
	from_object.obj_data[data_key] = new_data_value
	
static func add_data_value(from_object: Node, data_key: int, new_data_value: Variant) -> void:
	if has_data_key(from_object, data_key):
		var expected_array: Variant = get_data_value(from_object, data_key)
		if expected_array is Array:
			if (expected_array as Array).find(new_data_value):
				return # Data Already present.
			else:
				(from_object.obj_data[data_key] as Array).append(new_data_value) # Appends new value
	set_data_value(from_object, data_key, new_data_value) # What if we want an array instead?
## private methods
