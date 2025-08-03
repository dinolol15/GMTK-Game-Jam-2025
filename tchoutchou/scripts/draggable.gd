class_name Draggable
extends CollisionObject2D

var hovering = false
var dragging = false


func _input(event: InputEvent) -> void:
	if dragging:
		if event.is_action_released("click"):
			dragging = false
		elif event is InputEventMouseMotion:
			position += event.relative / Settings.camera_zoom
	elif hovering and event.is_action_pressed("click"):
		dragging = true


func _mouse_enter() -> void:
	hovering = true


func _mouse_exit() -> void:
	hovering = false
