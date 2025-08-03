@tool
class_name RopeLine
extends RopeRendererLine2D


func get_length() -> float:
	var length = 0.0
	var previous_point = points[-1]
	for point in points:
		length += previous_point.distance_to(point)
		previous_point = point
	return length


func update_rope_scale() -> void:
	set_instance_shader_parameter("rope_length", get_length())


func _process(_delta: float) -> void:
	update_rope_scale()
