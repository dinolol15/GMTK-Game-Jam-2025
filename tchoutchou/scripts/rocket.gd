extends CharacterBody2D

var speed = 200.0
var range = 1000.0
var turning_speed = 1.0
var hits_enemies = true
var hits_allies = true
var damage = 0.0

var distance_traveled = 0.0
var has_target = true

var explosion = preload("res://scenes/explosion.tscn")

var target: Node2D
var target_direction: Vector2
var target_distance: float
var targetted_group: String


func explode():
	var explosion_instance = explosion.instantiate()
	explosion_instance.position = position
	explosion_instance.damage = damage
	explosion_instance.hits_enemies = hits_enemies
	explosion_instance.hits_allies = hits_allies
	get_tree().root.add_child(explosion_instance) # explosion is parented under the root node
	queue_free()


func new_target():
	var possible_targets = get_tree().get_nodes_in_group(targetted_group)
	if possible_targets.size() == 0:
		has_target = false
	else:
		target = possible_targets[randi_range(0, possible_targets.size()-1)]
		has_target = true


func get_direction_to_target() -> Vector2:
	var direction = (target.global_position - global_position).normalized()
	return direction


func get_angle_to_target() -> float:
	return target_direction.angle() - global_rotation


func rotate_towards_target() -> void:
	var angle_to_target = get_angle_to_target()

	if abs(angle_to_target) < turning_speed:
		rotation += angle_to_target
	else:
		rotation += turning_speed * sign(angle_to_target)


func get_distance_to_target() -> float:
	return abs((target.global_position - global_position).length())


func _ready() -> void:
	pass


func _physics_process(_delta: float) -> void:
	if is_instance_valid(target):
		target_direction = get_direction_to_target()
		target_distance = get_distance_to_target()
	else:
		new_target()

	if has_target:
		rotate_towards_target()

		velocity = Vector2.from_angle(rotation) * speed
		distance_traveled += speed / 60
		move_and_slide()

	if distance_traveled >= range:
		explode()


func _on_trigger_area_entered(area: Area2D) -> void:
	if area.collision_layer == 2 and hits_allies or area.collision_layer == 4 and hits_enemies:
		explode()
