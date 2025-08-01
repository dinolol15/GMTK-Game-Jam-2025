@tool
class_name ProgressCircle
extends Polygon2D

@export_range(0.0, 1.0) var progress := 0.0:
	set(value):
		progress = value
		set_instance_shader_parameter("progress", progress)
