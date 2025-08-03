extends Node2D


var counter = 0
var strafer = preload("res://scenes/enemy_strafer.tscn")
var exploder = preload("res://scenes/enemy_exploder.tscn")


func _ready() -> void:
	pass


#func _physics_process(_delta: float) -> void:
	#if counter % 120 == 0:
		#var enemy_instance = strafer.instantiate()
#
		#enemy_instance.position = Vector2.from_angle(randf() * 2 * PI) * 1000
		#add_child(enemy_instance)
#
	#if counter % 180 == 90:
		#var enemy_instance = exploder.instantiate()
#
		#enemy_instance.position = Vector2.from_angle(randf() * 2 * PI) * 1000
		#add_child(enemy_instance)
#
	#counter += 1
