extends StaticBody2D


const BASE_HEALTH = 1000.0

var health = BASE_HEALTH
var is_alive = true
var play_damage_sound = false
var damage_sfx_cooldown = 0


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass
	#if play_damage_sound:
		#$DamageSFX.play()
		#play_damage_sound = false
		#damage_sfx_cooldown = randi_range(4, 6)
	#damage_sfx_cooldown -= 1


func _on_hitbox_body_entered(body: Node2D) -> void:
	play_damage_sound = true
	health -= body.damage
	body.queue_free()
	if health <= 0:
		get_node("Hitbox/CollisionShape2D").set_deferred("disabled", true)
		hide()
		is_alive = false
