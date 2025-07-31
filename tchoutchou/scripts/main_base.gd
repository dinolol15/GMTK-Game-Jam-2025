extends StaticBody2D


const BASE_HEALTH = 1000.0

var health = BASE_HEALTH
var is_alive = true


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _on_hitbox_body_entered(body: Node2D) -> void:
	health -= body.damage
	body.queue_free()
	if health <= 0:
		get_node("Hitbox/CollisionShape2D").set_deferred("disabled", true)
		hide()
		is_alive = false
