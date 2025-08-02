extends Path2D

@export var rope_loop: RopeLoop


func _process(_delta: float) -> void:
	curve.clear_points()
	for point in rope_loop.points:
		curve.add_point(point)
