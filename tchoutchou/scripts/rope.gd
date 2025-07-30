@tool
class_name Rope
extends Line2D


func get_length() -> float:
	var length = 0.0
	var previous_point = points[-1]
	for point in points:
		length += previous_point.distance_to(point)
	print(length)
	return length


func update_rope_scale() -> void:
	set_instance_shader_parameter("rope_length", get_length())


func _process(delta):
	update_rope_scale()
