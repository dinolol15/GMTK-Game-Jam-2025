extends Node2D

var cell_size = Vector2(32, 32)
var grid_size = Vector2(10, 10)
var arrows = [load("res://sprites/icon.svg"), load("res://sprites/placeholder-base.png")]
var choice = -1

var position_p = "Neuile frère"

func _ready():
	pass


func _input(event) -> void:
	if Input.is_action_just_pressed("click"):
		position_p = (get_global_mouse_position())
		var sprite = Sprite2D.new()
		sprite.texture = arrows[choice]
		sprite.position = position_p + sprite.scale
		add_child(sprite)
	elif Input.is_action_just_pressed("cursor"):
		choice += 1
		if choice > 1:
			choice = 0 
		Input.set_custom_mouse_cursor(arrows[choice])


func _process(delta):
	pass
