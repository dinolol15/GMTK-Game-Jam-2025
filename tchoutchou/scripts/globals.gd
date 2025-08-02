class_name Globals

enum Cargo {
	NONE,
	ANY,
	WOOD_LOG,
	WOOD_PLANK,
	STONE,
	COAL,
	IRON_ORE,
	IRON_BAR,
	COPPER_ORE,
	COPPER_BAR,
	OIL,
	FUEL,
	AMMO,
}
const CARGO_FRAMES: Dictionary[Globals.Cargo, int] = {
	Cargo.NONE: 10,
	Cargo.ANY: 21,
	Cargo.WOOD_LOG: 0,
	Cargo.WOOD_PLANK: 1,
	Cargo.STONE: 13,
	Cargo.COAL: 4,
	Cargo.IRON_ORE: 48,
	Cargo.IRON_BAR: 59,
	Cargo.COPPER_ORE: 46,
	Cargo.COPPER_BAR: 57,
	Cargo.OIL: 31,
	Cargo.FUEL: 32,
	Cargo.AMMO: 20,
}
