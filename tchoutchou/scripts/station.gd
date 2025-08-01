@tool
class_name Station
extends Area2D

@export var cargo_conversions: Array[CargoConversion]:
	set(value):
		cargo_conversions = value
		station_cargo_conversion_display.cargo_conversions = cargo_conversions

@export var station_cargo_conversion_display: StationCargoConversionDisplay
@export var cooldown_timer: Timer


func try_convert(from_cargo: Globals.Cargo) -> Globals.Cargo:
	if cooldown_timer.is_stopped():
		for conversion in cargo_conversions:
			if from_cargo == conversion.from_cargo:
				if conversion.cooldown != 0.0:
					cooldown_timer.start(conversion.cooldown)
				return conversion.to_cargo
	return from_cargo


func _process(_delta):
	station_cargo_conversion_display.cooldown_progress = cooldown_timer.time_left / cooldown_timer.wait_time
