extends CharacterBody2D

var speed = 500.0
var range = 1000.0
var is_enemy = true
var damage = 0.0
var distance = 0.0

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	velocity = Vector2.from_angle(rotation) * speed
	distance += speed / 60
	move_and_slide()

	if distance >= range:
		queue_free()
