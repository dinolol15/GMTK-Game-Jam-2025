@tool
class_name CargoStorageDisplay
extends Container

static var cargo_count_display_scene = preload("res://scenes/ui/cargo_count_display.tscn")


func update_cargo_count_displays() -> void:
	var num_cargo = Storage.cargo_storage.size()
	var new_cargo_count_display: CargoCountDisplay
	for i in range(max(num_cargo, get_child_count())):
		if i < num_cargo:
			if i >= get_child_count():
				new_cargo_count_display = cargo_count_display_scene.instantiate()
				add_child(new_cargo_count_display)
			get_child(i).cargo = Storage.cargo_storage.keys()[i]
			get_child(i).count = Storage.cargo_storage.values()[i]
		else:
			get_child(i).queue_free()


func _ready() -> void:
	Storage.cargo_storage_changed.connect(update_cargo_count_displays)
	update_cargo_count_displays()
