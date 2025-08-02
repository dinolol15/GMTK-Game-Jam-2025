@tool
class_name CargoSprite
extends Sprite2D

const CARGO_FRAMES: Dictionary[Globals.Cargo, int] = {
	Globals.Cargo.NONE: 10,
	Globals.Cargo.ANY: 21,
	Globals.Cargo.WOOD_LOG: 0,
	Globals.Cargo.WOOD_PLANK: 1,
	Globals.Cargo.STONE: 13,
	Globals.Cargo.COAL: 4,
	Globals.Cargo.IRON_ORE: 48,
	Globals.Cargo.IRON_BAR: 59,
	Globals.Cargo.COPPER_ORE: 46,
	Globals.Cargo.COPPER_BAR: 57,
	Globals.Cargo.OIL: 31,
	Globals.Cargo.FUEL: 32,
	Globals.Cargo.AMMO: 20,
}

@export var cargo: Globals.Cargo:
	set(value):
		cargo = value
		frame = CARGO_FRAMES[cargo]
