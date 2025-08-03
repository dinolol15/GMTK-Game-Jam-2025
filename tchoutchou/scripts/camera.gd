class_name PanZoomCamera
extends Camera2D

@export var zoom_step := 0.1
@export var min_zoom := 0.2
@export var max_zoom := 5.0

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.is_action_pressed("pan"):
		position -= event.relative / zoom
	elif event.is_action_pressed("zoom_in"):
		zoom *= 1.0 + zoom_step
		zoom = clamp(zoom, Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))
	elif event.is_action_pressed("zoom_out"):
		zoom *= 1.0 - zoom_step
		zoom = clamp(zoom, Vector2(min_zoom, min_zoom), Vector2(max_zoom, max_zoom))
	Settings.camera_zoom = zoom.x
