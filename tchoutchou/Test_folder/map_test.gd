extends Node2D

var cell_size = Vector2(32, 32)
var grid_size = Vector2(10, 10)
var arrows = [load("res://sprites/icon.svg"), load("res://sprites/placeholder-base.png")]
var choice = -1

var position_p = "Neuile frère"
var sprites = []

func _ready():
	pass


func _input(event) -> void:
	if Input.is_action_just_pressed("click") and choice >= 0:
		position_p = (get_global_mouse_position())
		var sprite = Sprite2D.new()
		sprite.texture = arrows[choice]
		sprite.position = position_p + (sprite.get_rect().size)/2
		sprites.append(sprite)
		add_child(sprite)
		Input.set_custom_mouse_cursor(null)
		choice = -1
	elif Input.is_action_pressed("click") and choice == -1:
		position_p = (get_global_mouse_position())
		for sprite in sprites:
			if (position_p <= sprite.position + sprite.get_rect().size
			 and position_p >= sprite.position - sprite.get_rect().size):
				sprite.position = position_p
				sprites.erase(sprite)
				sprites.push_front(sprite)
				break
		
	
	elif Input.is_action_just_pressed("cursor"):
		choice += 1
		if choice > 1:
			choice = 0 
		Input.set_custom_mouse_cursor(arrows[choice])


func _process(delta):
	pass
