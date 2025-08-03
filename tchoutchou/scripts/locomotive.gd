class_name Locomotive
extends PathFollow2D

@export var speed := 200.0
@export var wagon_separation := 72.0
@export var active := false:
	set(value):
		active = value
		if not active:
			progress = 0.0
			is_in_station = true
		visible = active
		for wagon in wagons:
			wagon.active = active

@export var wagons: Array[Wagon]

var is_in_station = true


func _process(delta: float) -> void:
	if not active:
		return

	progress += speed * delta
	if wagons.is_empty():
		return

	if is_in_station:
		for i in range(wagons.size()):
			wagons[i].progress = max(progress - wagon_separation * (i + 1), 0.0)
		if wagons[-1].progress > 0.0:
			is_in_station = false
	else:
		for i in range(wagons.size()):
			wagons[i].progress = progress - wagon_separation * (i + 1)
