@tool
class_name CargoSprite
extends Sprite2D

@export var cargo: Globals.Cargo:
	set(value):
		cargo = value
		frame = Globals.CARGO_FRAMES[cargo]
