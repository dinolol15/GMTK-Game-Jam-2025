extends StaticBody2D


const base_health = 1000.0

var health = base_health
var is_alive = true
var play_damage_sound = false
var damage_sfx_cooldown = 0


func _ready() -> void:
	pass


func process_hit(attack: Node2D):
	#play_damage_sound = true
	health -= attack.damage
	attack.targets_hit += 1
	if health <= 0:
		#get_node("Hitbox/CollisionShape2D").set_deferred("disabled", true)
		#get_node("PhysicsCollider").set_deferred("disabled", true)
		#hide()
		#is_alive = false
		queue_free()


func _process(_delta: float) -> void:
	$Healthbar.text = str(health)
	#if play_damage_sound:
		#$DamageSFX.play()
		#play_damage_sound = false
		#damage_sfx_cooldown = randi_range(4, 6)
	#damage_sfx_cooldown -= 1


func _on_hitbox_body_entered(attack: Node2D) -> void:
	if attack.hits_allies:
		process_hit(attack)

func _on_hitbox_area_entered(attack: Node2D) -> void:
	if attack.hits_allies:
		process_hit(attack)
