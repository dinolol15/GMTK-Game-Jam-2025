extends Node2D

@export var type = "gun"                # gun, flamethrower, laser, rocket
@export var targetted_group = "enemies" # enemies, allies
@export var base_damage = 10.0
@export var base_firerate = 2.0
@export var base_turning_speed = 360.0  # degrees / s
@export var min_distance = 0.0
@export var max_distance = 500.0
@export var hits_allies = true
@export var hits_enemies = true

var cooldown_length = int(60 / base_firerate) if base_firerate >= 0 else -1
var turning_speed = deg_to_rad(base_turning_speed / 60.0)

@export var is_active = true
var has_target = false
var cooldown = 0

var projectile: PackedScene
var muzzle_marker: Node2D
var backblast_marker: Node2D
var target: Node2D
var target_direction: Vector2
var target_distance: float


var bullet = preload("res://scenes/bullet.tscn")
#var flame = preload("res://scenes/fire.tscn")
#var laser = preload("res://scenes/laser.tscn")
var rocket = preload("res://scenes/rocket.tscn")


func new_target():
	var possible_targets = get_tree().get_nodes_in_group(targetted_group)
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

	if distance > max_distance:
		has_target = false
		return

	target = choice
	has_target = true


func _ready() -> void:
	$Sprite.play(type)
	match type:
		"gun":
			projectile = bullet
			muzzle_marker = $GunMuzzle
		#"flamethrower":
			#projectile = flame
			#muzzle_marker = $FlamethrowerMuzzle
		#"laser":
			#projectile = laser
			#muzzle_marker = $LaserMuzzle
		"rocket":
			projectile = rocket
			muzzle_marker = $RocketMuzzle
			#backblast_marker = $RocketBackblast


func get_direction_to_target() -> Vector2:
	var direction = (target.global_position - global_position).normalized()
	return direction


func get_angle_to_target() -> float:
	var angle = target_direction.angle() - global_rotation

	if angle > PI:
		angle -= 2*PI
	elif angle < -PI:
		angle += 2*PI

	return angle


func rotate_towards_target() -> void:
	var angle_to_target = get_angle_to_target()

	if abs(angle_to_target) < turning_speed:
		rotation += angle_to_target
	else:
		rotation += turning_speed * sign(angle_to_target)


func get_distance_to_target() -> float:
	return (target.global_position - global_position).length()


func is_target_in_range() -> bool:
	return target_distance >= min_distance and target_distance <= max_distance


func shoot() -> void:
	if cooldown > 0:
		return

	cooldown = cooldown_length
	var projectile_instance = projectile.instantiate()
	projectile_instance.position = muzzle_marker.global_position
	projectile_instance.rotation = global_rotation
	projectile_instance.damage = base_damage
	projectile_instance.hits_enemies = hits_enemies
	projectile_instance.hits_allies = hits_allies
	if type == "rocket":
		projectile_instance.target = target
		projectile_instance.targetted_group = targetted_group
	get_tree().root.add_child(projectile_instance) # bullet is parented under the root node
	$GunSFX.play()


func _physics_process(_delta: float) -> void:
	if is_instance_valid(target):
		target_distance = get_distance_to_target()
		if target_distance > max_distance:
			new_target()
		target_direction = get_direction_to_target()
	else:
		new_target()

	if is_active and has_target:
		rotate_towards_target()

		if is_target_in_range():
			shoot()

	if cooldown > 0:
		cooldown -= 1
