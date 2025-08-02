@tool
class_name Station
extends Area2D

signal cargo_converted(cargo_conversion: CargoConversion)

@export var cargo_conversions: Array[CargoConversion]:
	set(value):
		cargo_conversions = value
		if not is_node_ready():
			return
		station_cargo_conversion_display.cargo_conversions = cargo_conversions
@export_range(0.0, 1000.0) var transfer_range := 128.0:
	set(value):
		transfer_range = value
		if not is_node_ready():
			return
		collision_shape.shape.radius = transfer_range
		range_circle.radius = transfer_range
@export_color_no_alpha var range_circle_color := Color.AQUA:
	set(value):
		range_circle_color = value
		if not is_node_ready():
			return
		range_circle.fill_color = range_circle_color

@export var collision_shape: CollisionShape2D
@export var range_circle: RangeCircle
@export var station_cargo_conversion_display: StationCargoConversionDisplay
@export var cooldown_timer: Timer


func try_convert(from_cargo: Globals.Cargo) -> Globals.Cargo:
	if cooldown_timer.is_stopped():
		for cargo_conversion in cargo_conversions:
			if (from_cargo == cargo_conversion.from_cargo
			or cargo_conversion.from_cargo == Globals.Cargo.ANY):
				if cargo_conversion.cooldown != 0.0:
					cooldown_timer.start(cargo_conversion.cooldown)
				cargo_converted.emit(CargoConversion.from_args(
					from_cargo,
					cargo_conversion.to_cargo,
					cargo_conversion.cooldown
				))
				return cargo_conversion.to_cargo
	return from_cargo


func _ready():
	collision_shape.shape = collision_shape.shape.duplicate()


func _process(_delta: float):
	station_cargo_conversion_display.cooldown_progress = cooldown_timer.time_left / cooldown_timer.wait_time
