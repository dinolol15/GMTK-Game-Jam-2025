@tool
class_name CargoSprite
extends Sprite2D

const CARGO_FRAMES: Dictionary[Globals.Cargo, int] = {
	Globals.Cargo.NONE: 10,
	Globals.Cargo.WOOD_LOG: 0,
	Globals.Cargo.WOOD_PLANK: 1,
	Globals.Cargo.STONE: 13,
	Globals.Cargo.COAL: 4,
	Globals.Cargo.IRON_ORE: 37,
	Globals.Cargo.IRON_BAR: 59,
	Globals.Cargo.COPPER_ORE: 35,
	Globals.Cargo.COPPER_BAR: 57,
}

@export var cargo: Globals.Cargo:
	set(value):
		cargo = value
		frame = CARGO_FRAMES[cargo]
