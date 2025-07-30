extends CharacterBody2D


const BASE_HEALTH = 100.0
const BASE_SPEED = 50.0
const BASE_DAMAGE = 20.0
const BASE_FIRERATE = 2.0

var projectile
var counter = randi_range(0, 60)

var health = BASE_HEALTH
var target = Vector2(0.0, 0.0)
var direction_to_target = Vector2(0.0, 0.0)
var attack_cooldown = int(60 / BASE_FIRERATE)


func get_direction(new_target_position: Vector2):
	var direction = (new_target_position - position).normalized()
	return direction


func get_distance_to_target():
	return abs((target - position).length())


func _ready() -> void:
	projectile = load("res://scenes/bullet.tscn")


func _physics_process(delta: float) -> void:
	target = get_node("../MainBase").position
	direction_to_target = get_direction(target)
	if get_distance_to_target() > 200:
		velocity = direction_to_target * BASE_SPEED
	else:
		velocity = Vector2.ZERO
	rotation = direction_to_target.angle()

	if counter % attack_cooldown == 0:
		var projectile_instance = projectile.instantiate()
		projectile_instance.position = position
		projectile_instance.rotation = direction_to_target.angle()
		projectile_instance.damage = BASE_DAMAGE
		get_parent().add_child(projectile_instance)


	counter += 1
	move_and_slide()
