extends CharacterBody2D


@export var BASE_HEALTH = 10.0
@export var BASE_SPEED = 50.0
@export var BASE_DAMAGE = 2.0
@export var BASE_FIRERATE = 1.0
@export var DESIRED_DISTANCE = 200.0
@export var AI_TYPE = "strafer"         # strafer, exploder
const STRAFE_SHARPNESS = 0.02           # used for the AI; don't worry about it


var projectile = preload("res://scenes/bullet.tscn")
var counter = randi_range(0, 60)

var health = BASE_HEALTH
var target = Vector2(0.0, 0.0)
var direction_to_target = Vector2(0.0, 0.0)
var attack_cooldown = int(60 / BASE_FIRERATE) if BASE_FIRERATE >= 0 else -1


func get_direction(new_target_position: Vector2):
	var direction = (new_target_position - position).normalized()
	return direction


func get_distance_to_target():
	return abs((target.position - position).length())


func shoot():
	var projectile_instance = projectile.instantiate()
	projectile_instance.position = position
	projectile_instance.rotation = direction_to_target
	projectile_instance.damage = BASE_DAMAGE
	get_parent().add_child(projectile_instance) # bullet is parented under the root node
	#$GunSFX.play()


func _ready() -> void:
	target = get_node("../MainBase")


func _physics_process(delta: float) -> void:
	direction_to_target = get_direction(target.position).angle()

	# Handle the artificial "intelligence"
	match AI_TYPE:
		"strafer":
			# Used desmos to find a nice equation
			# y=-\arctan\left(S\left(x-R_{d}\right)\right)+\frac{\pi}{2}  ## angle offset as a function of distance
			# It makes the enemy settle into a circle around the target, without managing any states or things like that
			rotation = direction_to_target - atan(STRAFE_SHARPNESS * (get_distance_to_target() - DESIRED_DISTANCE)) + PI/2

			if counter % attack_cooldown == 0 and target.is_alive:
				shoot()

		"exploder":
			rotation = direction_to_target

	velocity = BASE_SPEED * Vector2.from_angle(rotation)




	counter += 1
	move_and_slide()
