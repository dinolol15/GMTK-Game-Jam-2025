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
