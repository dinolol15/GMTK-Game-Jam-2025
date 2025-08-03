@tool
class_name CargoCountDisplay
extends Control

@export var cargo: Globals.Cargo:
	set(value):
		cargo = value
		cargo_texture_rect.cargo = cargo
@export var count := 0:
	set(value):
		count = value
		label.text = str(count)

@export var cargo_texture_rect: CargoTextureRect
@export var label: Label
