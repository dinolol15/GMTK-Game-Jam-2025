extends CharacterBody2D

var speed = 500.0
var range = 1000.0
var hits_enemies = true
var hits_allies = true
var damage = 0.0


var distance_traveled = 0.0
var targets_hit = 0


func _ready() -> void:
	pass


func _physics_process(_delta: float) -> void:
	velocity = Vector2.from_angle(rotation) * speed
	distance_traveled += speed / 60
	move_and_slide()

	if distance_traveled >= range:
		queue_free()

	if targets_hit > 0:
		queue_free()
