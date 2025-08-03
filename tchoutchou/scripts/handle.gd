extends Area2D

signal moved(old_position: Vector2, new_position: Vector2)

@export var snap_distance = 64.0

var hovering = false
var dragging = false

var unsnapped_position: Vector2

func _input(event: InputEvent) -> void:
	if dragging:
		if event.is_action_released("click"):
			dragging = false
		elif event is InputEventMouseMotion:
			var old_position = position
			unsnapped_position += event.relative / Settings.camera_zoom
			if unsnapped_position.length() <= snap_distance:
				position = Vector2.ZERO
			else:
				position = unsnapped_position
			moved.emit(old_position, position)
	elif hovering and event.is_action_pressed("click"):
		unsnapped_position = position
		dragging = true


func _on_mouse_entered() -> void:
	hovering = true


func _on_mouse_exited() -> void:
	hovering = false
