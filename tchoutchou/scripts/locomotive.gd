class_name Locomotive
extends PathFollow2D

@export var speed := 100.0
@export var wagon_separation := 72.0

@export var wagons: Array[Wagon]


func _process(delta):
	progress += speed * delta
	for i in range(wagons.size()):
		wagons[i].progress = progress - wagon_separation * (i + 1)
