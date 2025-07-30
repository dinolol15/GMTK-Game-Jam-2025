extends Node2D


var counter = 0
var enemy


func _ready() -> void:
	enemy = load("res://scenes/enemy_.tscn")


func _physics_process(delta: float) -> void:
	if counter % 60 == 0:
		var enemy_instance = enemy.instantiate()

		enemy_instance.position = Vector2.from_angle(randf() * 2 * PI) * 500
		add_child(enemy_instance)

	counter += 1
