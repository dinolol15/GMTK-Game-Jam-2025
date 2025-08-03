class_name Draggable
extends CollisionObject2D

var hovering = false
var dragging = false


func _mouse_enter() -> void:
	hovering = true


func _mouse_exit() -> void:
	hovering = false


func _on_loop_started() -> void:
	dragging = false


func _input(event: InputEvent) -> void:
	if dragging:
		if event.is_action_released("click"):
			dragging = false
		elif event is InputEventMouseMotion and not Input.is_action_pressed("pan"):
			position += event.relative / Globals.camera_zoom
	elif hovering and event.is_action_pressed("click") and not Globals.looping:
		dragging = true


func _ready() -> void:
	Globals.loop_started.connect(_on_loop_started)
