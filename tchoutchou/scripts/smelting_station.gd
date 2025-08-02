@tool
class_name SmeltingStation
extends Station

@export var fuel := Globals.Cargo.NONE:
	set(value):
		fuel = value
		update_station_cargo_conversions()
@export var burn_cargo_conversions: Array[CargoConversion]:
	set(value):
		burn_cargo_conversions = value
		update_station_cargo_conversions()
@export var is_fueled = false:
	set(value):
		is_fueled = value
		update_station_cargo_conversions()


func update_station_cargo_conversions() -> void:
	if is_fueled:
		cargo_conversions = burn_cargo_conversions
	else:
		cargo_conversions = [CargoConversion.from_args(fuel)]


func _on_cargo_converted(_cargo_conversion: CargoConversion) -> void:
	is_fueled = not is_fueled


func _ready() -> void:
	update_station_cargo_conversions()
