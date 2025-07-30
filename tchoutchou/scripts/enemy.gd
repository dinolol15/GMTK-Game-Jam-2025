extends CharacterBody2D


const BASE_HEALTH = 100.0
const BASE_SPEED = 50.0
const BASE_DAMAGE = 20.0


var health = BASE_HEALTH
var target = Vector2(0.0, 0.0)
var direction_to_target = Vector2(0.0, 0.0)


func get_direction(new_target_position: Vector2):
	var direction = (new_target_position - position).normalized()
	return direction


func _ready() -> void:
	target = get_node("../MainBase").position


func _physics_process(delta: float) -> void:
	direction_to_target = get_direction(target)
	velocity = direction_to_target * BASE_SPEED
	rotation = direction_to_target.angle()



	move_and_slide()
