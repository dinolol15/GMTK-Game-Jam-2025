@tool
class_name LoopPath
extends Path2D

signal loop_closed()
signal loop_opened()

@export var max_length := 200.0:
	set(value):
		max_length = value
		rope.rope_length = max_length
		rope.num_segments = roundi(max_length * segment_density)
@export var segment_density := 0.25:
	set(value):
		rope.num_segments = roundi(max_length * segment_density)
@export var elasticity := 0.4

@export var rope_line: RopeLine
@export var handle: Node2D
@export var rope: Rope


func get_rope_length() -> float:
	return rope_line.get_length()


func _on_handle_moved(old_position: Vector2, new_position: Vector2) -> void:
	if new_position.is_equal_approx(Vector2.ZERO) and not old_position.is_equal_approx(Vector2.ZERO):
		loop_closed.emit()
	elif old_position.is_equal_approx(Vector2.ZERO) and not new_position.is_equal_approx(Vector2.ZERO):
		loop_opened.emit()


func _physics_process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return
	max_length = get_rope_length() * elasticity


func _process(_delta: float) -> void:
	curve.clear_points()
	for point in rope_line.points:
		curve.add_point(point)
