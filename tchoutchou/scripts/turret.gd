extends Node2D

@export var type = "gun"                # gun, flamethrower, laser, rocket
@export var base_damage = 10.0
@export var base_firerate = 2.0
@export var base_turning_speed = 360.0  # degrees / s
@export var min_distance = 0.0
@export var max_distance = 500.0
@export var hits_allies = true
@export var hits_enemies = true

var cooldown_length = int(60 / base_firerate) if base_firerate >= 0 else -1
var rotation_speed = deg_to_rad(base_turning_speed / 60.0)

var is_active = false
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


func _ready() -> void:
	target = get_tree().root.get_node("Level/MainBase")
	is_active = true
	has_target = true

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
			backblast_marker = $RocketBackblast


func get_direction_to_target() -> Vector2:
	var direction = (target.global_position - global_position).normalized()
	return direction


func get_angle_to_target() -> float:
	return target_direction.angle() - global_rotation


func rotate_towards_target() -> void:
	var angle_to_target = get_angle_to_target()

	if abs(angle_to_target) < rotation_speed:
		global_rotation = target_direction.angle()
	else:
		rotation += rotation_speed * sign(angle_to_target)


func get_distance_to_target() -> float:
	return abs((target.global_position - global_position).length())


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
	get_tree().root.add_child(projectile_instance) # bullet is parented under the root node
	#$GunSFX.play()


func _physics_process(_delta: float) -> void:
	if is_instance_valid(target):
		target_direction = get_direction_to_target()
		target_distance = get_distance_to_target()
	else:
		has_target = false

	if is_active and has_target:
		rotate_towards_target()

		if is_target_in_range():
			shoot()



	if cooldown > 0:
		cooldown -= 1
