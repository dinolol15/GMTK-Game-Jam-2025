@tool
class_name PlaceableDisplay
extends VBoxContainer

@export var placeable: Placeable:
	set(value):
		if placeable != null and placeable.changed.is_connected(_on_placeable_changed):
			placeable.changed.disconnect(_on_placeable_changed)
		placeable = value
		if placeable != null:
			placeable.changed.connect(_on_placeable_changed)
		_on_placeable_changed()

@export var cargo_count_display_container: Container
@export var name_label: Label
@export var cargo_texture_rect: CargoTextureRect

static var cargo_count_display_scene = preload("res://scenes/ui/small_cargo_count_display.tscn")

var price = {}
var previous_price = {}


func update_cargo_count_displays() -> void:
	var num_cargo = price.size()
	var new_cargo_count_display: CargoCountDisplay
	for i in range(max(num_cargo, cargo_count_display_container.get_child_count())):
		if i < num_cargo:
			if i >= cargo_count_display_container.get_child_count():
				new_cargo_count_display = cargo_count_display_scene.instantiate()
				cargo_count_display_container.add_child(new_cargo_count_display)
			cargo_count_display_container.get_child(i).cargo = price.keys()[i]
			cargo_count_display_container.get_child(i).count = price.values()[i]
		else:
			cargo_count_display_container.get_child(i).queue_free()


func _on_placeable_changed() -> void:
	name_label.text = placeable.name if placeable != null else ""
	cargo_texture_rect.cargo = placeable.icon if placeable != null else Globals.Cargo.NONE


func _process(_delta: float) -> void:
	price = placeable.price if placeable != null else {}
	if price != previous_price:
		update_cargo_count_displays()
		previous_price = price.duplicate()
