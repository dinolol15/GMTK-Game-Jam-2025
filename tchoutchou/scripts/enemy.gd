extends CharacterBody2D


@export var base_health = 30.0
@export var base_speed = 50.0
@export var speed_multiplier = 2.0      # How much the enemy's speed will change when some condition is met (depends on enemy type)
@export var base_damage = 2.0           # How much damage is dealt by each attack
@export var base_firerate = 1.0         # Hz; how often the enemy will attack
@export var attack_distance = 250.0     # units; distance to the target at which the enemy will start to attack
@export var enemy_type = "strafer"      # strafer, exploder
const strafe_sharpness = 0.02           # used for the AI; don't worry about it


var projectile = preload("res://scenes/bullet.tscn")
var explosion = preload("res://scenes/explosion.tscn")
var counter = randi_range(0, 60)

var health = base_health
var attack_cooldown = int(60 / base_firerate) if base_firerate >= 0 else -1
var has_target = false

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
	$GunSFX.play()

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


func new_target():
	var possible_targets = get_tree().get_nodes_in_group("allies")
	if possible_targets.size() == 0:
		has_target = false
		return

	var choice: Node2D
	var distance = INF

	for new_choice in possible_targets:
		var new_distance = (new_choice.global_position - global_position).length()
		if new_distance < distance:
			choice = new_choice
			distance = new_distance

	target = choice
	has_target = true


func strafer_ai_tick():
	if not has_target:
		# TODO: implement target switching and priorities
		return

	# Used desmos to find a nice equation
	# y=-\arctan\left(S\left(x-R_{d}\right)\right)+\frac{\pi}{2}  ## angle offset as a function of distance
	# It makes the enemy settle into a circle around the target, without managing any states or things like that
	rotation = target_direction.angle() - atan(strafe_sharpness * (get_distance_to_target() - attack_distance * 0.8)) + PI/2
	velocity = base_speed * Vector2.from_angle(rotation)

	#if counter % attack_cooldown == 0 and target.is_alive and target_distance <= attack_distance:
		#shoot(base_damage, false, true)


func exploder_ai_tick():
	if not has_target:
		return
	rotation = target_direction.angle()
	velocity = base_speed * target_direction

	if $Trigger.has_overlapping_bodies() or $Trigger.has_overlapping_areas():
		explode(base_damage, true, true)

	if target_distance < attack_distance:
		velocity *= speed_multiplier


func _ready() -> void:
	add_to_group("enemies")
	target = get_node("../MainBase")
	has_target = true


func _physics_process(_delta: float) -> void:
	if is_instance_valid(target):
		target_direction = get_direction_vector(target.position)
		target_distance = get_distance_to_target()
	else:
		new_target()

	# Handle the artificial "intelligence"
	match enemy_type:
		"strafer":
			strafer_ai_tick()
		"exploder":
			exploder_ai_tick()

	counter += 1
	move_and_slide()
