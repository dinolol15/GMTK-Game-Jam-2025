@tool
class_name RangeCircle
extends Polygon2D

@export_range(0.0, 1000.0) var radius := 128.0:
	set(value):
		radius = value
		set_instance_shader_parameter("radius", radius)
@export_color_no_alpha var fill_color := Color.AQUA:
	set(value):
		fill_color = value
		set_instance_shader_parameter("fill_color", fill_color)
