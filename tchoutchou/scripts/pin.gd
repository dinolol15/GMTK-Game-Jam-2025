class_name Pin
extends AnimatableBody2D


func _input(event: InputEvent) -> void:
	if (Input.is_action_just_pressed("click")
	or (Input.is_action_pressed("click") and event is InputEventMouseMotion)):
		position = get_global_mouse_position()
