@tool
class_name CargoConversion
extends Resource

@export var from_cargo := Globals.Cargo.NONE:
	set(value):
		from_cargo = value
		emit_changed()
@export var to_cargo := Globals.Cargo.NONE:
	set(value):
		to_cargo = value
		emit_changed()
@export var cooldown := 0.0:
	set(value):
		cooldown = value
		emit_changed()


@warning_ignore("shadowed_variable")
static func from_args(from_cargo := Globals.Cargo.NONE, to_cargo := Globals.Cargo.NONE, cooldown := 0.0):
	var new_cargo_conversion = CargoConversion.new()
	new_cargo_conversion.from_cargo = from_cargo
	new_cargo_conversion.to_cargo = to_cargo
	new_cargo_conversion.cooldown = cooldown
	return new_cargo_conversion
