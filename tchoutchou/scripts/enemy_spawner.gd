extends Node2D

var wave = -1
var spawning_in_progress = false
var enemies = []
var spawn_delay = 0
var wave_delay = 0

var counter = 0
var strafer = preload("res://scenes/enemy_strafer.tscn")
var exploder = preload("res://scenes/enemy_exploder.tscn")

var waves = [
	{
		"spawn_delay": 0, # seconds
		"wave_delay": 300.0,
		"enemies": {
			strafer: 0,
			exploder: 0
		}
	},
	{
		"spawn_delay": 5.0, # seconds
		"wave_delay": 180.0,
		"enemies": {
			strafer: 3,
			exploder: 0
		}
	},
	{
		"spawn_delay": 4.0, # seconds
		"wave_delay": 150.0,
		"enemies": {
			strafer: 5,
			exploder: 1
		}
	},
	{
		"spawn_delay": 3.0, # seconds
		"wave_delay": 120.0,
		"enemies": {
			strafer: 8,
			exploder: 2
		}
	},
	{
		"spawn_delay": 2.0, # seconds
		"wave_delay": 90.0,
		"enemies": {
			strafer: 12,
			exploder: 4
		}
	},
	{
		"spawn_delay": 1.0, # seconds
		"wave_delay": 60.0,
		"enemies": {
			strafer: 15,
			exploder: 5
		}
	},
	{
		"spawn_delay": 0.5, # seconds
		"wave_delay": 30.0,
		"enemies": {
			strafer: 20,
			exploder: 8
		}
	},
]


func _ready():
	#print("hello?")
	#next_wave()
	pass


func next_wave():
	counter = 0
	wave += 1

	if wave >= len(waves):
		wave = len(waves) - 1

	print("starting wave ", wave)
	enemies = []
	spawn_delay = int(waves[wave]["spawn_delay"] * 60)
	wave_delay = int(waves[wave]["wave_delay"] * 60)

	for enemy in waves[wave]["enemies"]:
		for i in range(waves[wave]["enemies"][enemy]):
			enemies.append(enemy)

	enemies.shuffle()
	print(len(enemies), " enemies")
	spawning_in_progress = true


func _physics_process(_delta: float):
	#print("wave: ", wave, "\ncounter: ", counter)
	if spawning_in_progress:
		if len(enemies) == 0:
			spawning_in_progress = false
			return

		if counter > spawn_delay:
			counter = 0
			print("spawning enemy!")
			var enemy_instance = enemies.pop_front().instantiate()

			enemy_instance.position = Vector2.from_angle(randf() * 2 * PI) * 1000
			get_tree().root.add_child(enemy_instance)
	elif counter > wave_delay:
		next_wave()
	#print(counter > wave_delay * 60)
	counter += 1
