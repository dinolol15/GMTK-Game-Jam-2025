@tool
class_name PlaceableDisplay
extends VBoxContainer

signal placeable_bought(placeable: Placeable)

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
@export var buy_button: BaseButton
@export var cargo_texture_rect: CargoTextureRect

static var cargo_count_display_scene = preload("res://scenes/ui/small_cargo_count_display.tscn")

var price = {}
var previous_price = {}


func update_can_afford() -> void:
	var can_afford = true
	for cargo in placeable.price:
		if (not Storage.cargo_storage.has(cargo)
		or Storage.cargo_storage[cargo] < placeable.price[cargo]):
			can_afford = false
			break
	buy_button.disabled = not can_afford
	cargo_texture_rect.modulate = Color.WHITE if can_afford else Color.DIM_GRAY


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


func _on_buy_button_pressed() -> void:
	if Globals.looping:
		return
	for cargo in placeable.price:
		Storage.add_cargo(cargo, -placeable.price[cargo])
	placeable_bought.emit(placeable)


func _ready() -> void:
	Storage.cargo_storage_changed.connect(update_can_afford)


func _process(_delta: float) -> void:
	price = placeable.price if placeable != null else {}
	if price != previous_price:
		update_can_afford()
		update_cargo_count_displays()
		previous_price = price.duplicate()
