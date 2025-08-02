extends CharacterBody2D


@export var BASE_HEALTH = 10.0
@export var BASE_SPEED = 50.0
@export var SPEED_MULTIPLIER = 2.0      # How much the enemy's speed will change when some condition is met (depends on enemy type)
@export var BASE_DAMAGE = 2.0           # How much damage is dealt by each attack
@export var BASE_FIRERATE = 1.0         # Hz; how often the enemy will attack
@export var ATTACK_DISTANCE = 250.0     # units; distance to the target at which the enemy will start to attack
@export var ENEMY_TYPE = "strafer"      # strafer, exploder
const STRAFE_SHARPNESS = 0.02           # used for the AI; don't worry about it


var projectile = preload("res://scenes/bullet.tscn")
var explosion = preload("res://scenes/explosion.tscn")
var counter = randi_range(0, 60)

var health = BASE_HEALTH
var attack_cooldown = int(60 / BASE_FIRERATE) if BASE_FIRERATE >= 0 else -1

var target: Node2D
var target_direction: Vector2
var target_distance: float


func get_direction_vector(new_target_position: Vector2):
	var direction = (new_target_position - position).normalized()
	return direction


func get_distance_to_target():
	return abs((target.position - position).length())


func shoot(damage: float, hits_enemies: bool, hits_allies: bool):
	var projectile_instance = projectile.instantiate()
	projectile_instance.position = position
	projectile_instance.rotation = target_direction.angle()
	projectile_instance.damage = damage
	projectile_instance.hits_enemies = hits_enemies
	projectile_instance.hits_allies = hits_allies
	get_parent().add_child(projectile_instance) # bullet is parented under the root node
	#$GunSFX.play()

func explode(damage: float, hits_enemies: bool, hits_allies: bool):
	var explosion_instance = explosion.instantiate()
	explosion_instance.position = position
	explosion_instance.damage = damage
	explosion_instance.hits_enemies = hits_enemies
	explosion_instance.hits_allies = hits_allies
	get_parent().add_child(explosion_instance) # explosion is parented under the root node
	queue_free()


func _on_hitbox_area_entered(attack: Area2D) -> void:
	if attack.hits_enemies:
		process_hit(attack)


func _on_hitbox_body_entered(attack: Node2D) -> void:
	if attack.hits_enemies:
		process_hit(attack)


func process_hit(attack: Node2D):
	health -= attack.damage
	attack.targets_hit += 1
	if health <= 0:
		queue_free()


func _ready() -> void:
	target = get_node("../MainBase")


func _physics_process(delta: float) -> void:
	target_direction = get_direction_vector(target.position)
	target_distance = get_distance_to_target()

	# Handle the artificial "intelligence"
	match ENEMY_TYPE:
		"strafer":
			# Used desmos to find a nice equation
			# y=-\arctan\left(S\left(x-R_{d}\right)\right)+\frac{\pi}{2}  ## angle offset as a function of distance
			# It makes the enemy settle into a circle around the target, without managing any states or things like that
			rotation = target_direction.angle() - atan(STRAFE_SHARPNESS * (get_distance_to_target() - ATTACK_DISTANCE * 0.8)) + PI/2
			velocity = BASE_SPEED * Vector2.from_angle(rotation)

			if counter % attack_cooldown == 0 and target.is_alive and target_distance <= ATTACK_DISTANCE:
				shoot(BASE_DAMAGE, false, true)

		"exploder":
			rotation = target_direction.angle()
			velocity = BASE_SPEED * target_direction

			if $Trigger.has_overlapping_bodies() or $Trigger.has_overlapping_areas():
				explode(BASE_DAMAGE, true, true)

			if target_distance < ATTACK_DISTANCE:
				velocity *= SPEED_MULTIPLIER



	counter += 1
	move_and_slide()
