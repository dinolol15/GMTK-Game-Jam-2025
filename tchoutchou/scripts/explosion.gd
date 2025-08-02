extends Area2D


var lifetime = 6 # ticks
var damage = 0.0
var hits_enemies = true
var hits_allies = true

var targets_hit = 0


func _ready() -> void:
	pass


func _physics_process(_delta: float) -> void:
	if lifetime <= 0:
		queue_free()

	lifetime -= 1
