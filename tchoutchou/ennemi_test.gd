extends CharacterBody2D

# Please move to res://scripts

const speed = 50.0

@export var player: CharacterBody2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	make_path()

func _physics_process(_delta: float):
	var direction = to_local(navigation_agent.get_next_path_position()).normalized()
	velocity = speed * direction
	move_and_slide()

func make_path():
	navigation_agent.target_position = player.global_position


func _on_timer_timeout():
	make_path()
