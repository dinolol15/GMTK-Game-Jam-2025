extends CharacterBody2D

const speed = 100.0

@export var player: CharacterBody2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	navigation_agent.avoidance_enabled = true
	navigation_agent.avoidance_layers = 1
	navigation_agent.avoidance_mask = 2
	make_path()

func _physics_process(_delta: float):
	var direction = to_local(navigation_agent.get_next_path_position()).normalized()
	velocity = speed * direction
	move_and_slide()

func make_path():
	navigation_agent.target_position = player.global_position
	

func _on_timer_timeout():
	make_path()
