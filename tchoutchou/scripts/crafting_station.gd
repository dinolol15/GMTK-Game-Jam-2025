@tool
class_name CraftingStation
extends Station

@export var ingredients: Dictionary[Globals.Cargo, bool]
@export var result := Globals.Cargo.NONE:
	set(value):
		result = value
		update_station_cargo_conversions()

var previous_ingredients = {}


func update_station_cargo_conversions() -> void:
	var new_cargo_conversions: Array[CargoConversion] = []
	for cargo in ingredients:
		if not ingredients[cargo]:
			new_cargo_conversions.append(CargoConversion.from_args(cargo))
	if new_cargo_conversions.size() == 1:
		new_cargo_conversions[0].to_cargo = result
	cargo_conversions = new_cargo_conversions


func _on_cargo_converted(cargo_conversion: CargoConversion) -> void:
	if ingredients.has(cargo_conversion.from_cargo):
		ingredients[cargo_conversion.from_cargo] = true
	if ingredients.values().all(func(element): return element):
		for cargo in ingredients:
			ingredients[cargo] = false


func _process(_delta) -> void:
	if ingredients != previous_ingredients:
		update_station_cargo_conversions()
		previous_ingredients = ingredients.duplicate()
