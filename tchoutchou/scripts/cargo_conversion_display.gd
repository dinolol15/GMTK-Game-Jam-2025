@tool
class_name CargoConversionDisplay
extends Node2D

@export var cargo_conversion: CargoConversion:
	set(value):
		if cargo_conversion != null and cargo_conversion.changed.is_connected(_on_cargo_conversion_changed):
			cargo_conversion.changed.disconnect(_on_cargo_conversion_changed)
		cargo_conversion = value
		if cargo_conversion != null:
			cargo_conversion.changed.connect(_on_cargo_conversion_changed)
		_on_cargo_conversion_changed()

@export var from_cargo_sprite: CargoSprite
@export var to_cargo_sprite: CargoSprite


func _on_cargo_conversion_changed() -> void:
	from_cargo_sprite.cargo = cargo_conversion.from_cargo
	to_cargo_sprite.cargo = cargo_conversion.to_cargo
