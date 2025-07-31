class_name RopeMine
extends Line2D

@export var max_points := 2048
@export var max_segment_length := 20.0

@export var shape_cast: ShapeCast2D


func get_length() -> float:
	var length = 0.0
	var previous_point = points[-1]
	for point in points:
		length += previous_point.distance_to(point)
		previous_point = point
	return length


func update_rope_scale() -> void:
	set_instance_shader_parameter("rope_length", get_length())


func update_points() -> void:
	var new_points = PackedVector2Array()
	var point_1 = points[-2]
	var point_2 = points[-1]
	var new_point: Vector2
	var num_segments: int
	var segment_fraction: float

	for point_3 in points:
		num_segments = ceili(point_2.distance_to(point_3) / max_segment_length)
		for i in range(num_segments):
			segment_fraction = float(i + 1) / num_segments
			new_points.append(point_2.lerp(point_3, segment_fraction))

		point_1 = point_2
		point_2 = point_3

	points = new_points.slice(0, max_points)
	new_points.clear()

	for point_3 in points:
		shape_cast.position = point_1
		shape_cast.target_position = point_3 - point_1
		shape_cast.force_shapecast_update()

		if shape_cast.get_collision_count() > 0 or new_points.size() < 3:
			shape_cast.position = point_1
			shape_cast.target_position = point_2 - point_1
			shape_cast.force_shapecast_update()

			if shape_cast.get_collision_count() > 0:
				new_point = shape_cast.get_collision_point(0) + shape_cast.get_collision_normal(0) * 15.0
				new_points.append(new_point)
			new_points.append(point_2)

			point_1 = point_2
			point_2 = point_3
		else:
			point_2 = point_3

	points = new_points.slice(0, max_points)
	update_rope_scale()


func _process(_delta):
	update_points()
