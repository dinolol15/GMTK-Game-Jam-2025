extends CharacterBody2D


const BASE_HEALTH = 100.0
const BASE_SPEED = 300.0
const BASE_DAMAGE = 20.0


var health


func _physics_process(delta: float) -> void:




	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
