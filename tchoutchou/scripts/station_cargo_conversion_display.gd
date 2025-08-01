@tool
class_name StationCargoConversionDisplay
extends Node2D

const CARGO_CONVERSION_DISPLAY_SEPARATION = 52.0

@export var cargo_conversions: Array[CargoConversion]
@export_range(0.0, 1.0) var cooldown_progress := 1.0:
	set(value):
		cooldown_progress = value
		sprite_root.modulate = Color.WHITE if cooldown_progress == 0.0 else Color.DIM_GRAY
		progress_circle.progress = cooldown_progress

@export var sprite_root: Node2D
@export var progress_circle: ProgressCircle

static var cargo_conversion_display_scene = preload("res://scenes/cargo_conversion_display.tscn")

var previous_cargo_conversions = []


func _on_cargo_conversions_changed() -> void:
	var num_cargo_conversions = cargo_conversions.size()
	var new_cargo_conversion_display: CargoConversionDisplay
	for i in range(max(num_cargo_conversions, sprite_root.get_child_count())):
		if i < num_cargo_conversions:
			if i >= sprite_root.get_child_count():
				new_cargo_conversion_display = cargo_conversion_display_scene.instantiate()
				sprite_root.add_child(new_cargo_conversion_display)
			sprite_root.get_child(i).cargo_conversion = cargo_conversions[i]
			sprite_root.get_child(i).position.y = -CARGO_CONVERSION_DISPLAY_SEPARATION * (num_cargo_conversions - i - 1)
		else:
			sprite_root.get_child(i).queue_free()
	progress_circle.position.y = -CARGO_CONVERSION_DISPLAY_SEPARATION * (num_cargo_conversions - 1) / 2.0


func _process(_delta) -> void:
	if previous_cargo_conversions != cargo_conversions:
		_on_cargo_conversions_changed()
		previous_cargo_conversions = cargo_conversions.duplicate()
