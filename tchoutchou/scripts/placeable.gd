@tool
class_name Placeable
extends Resource

@export var name := "":
	set(value):
		name = value
		emit_changed()
@export var icon: Globals.Cargo:
	set(value):
		icon = value
		emit_changed()
@export var price: Dictionary[Globals.Cargo, int]
@export var scene: PackedScene
