@tool
extends Node

signal cargo_storage_changed()

var cargo_storage = {
	Globals.Cargo.WOOD_LOG: 0,
	Globals.Cargo.WOOD_PLANK: 0,
	Globals.Cargo.STONE: 0,
	Globals.Cargo.IRON_BAR: 0,
	Globals.Cargo.COPPER_BAR: 0,
}

func add_cargo(cargo: Globals.Cargo, amount := 1) -> void:
	if cargo_storage.has(cargo):
		cargo_storage[cargo] += amount
		cargo_storage_changed.emit()
