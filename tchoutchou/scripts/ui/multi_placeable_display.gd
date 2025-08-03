@tool
class_name MultiPlaceableDisplay
extends HBoxContainer

signal placeable_bought(placeable: Placeable)

@export var placeables: Array[Placeable]

static var placeable_display_scene = preload("res://scenes/ui/placeable_display.tscn")

var previous_placeables = []


func update_placeable_displays() -> void:
	var num_placeables = placeables.size()
	var new_placeable_display: PlaceableDisplay
	for i in range(max(num_placeables, get_child_count())):
		if i < num_placeables:
			if i >= get_child_count():
				new_placeable_display = placeable_display_scene.instantiate()	
				new_placeable_display.placeable_bought.connect(_on_placeable_display_placeable_bought)
				add_child(new_placeable_display)
			get_child(i).placeable = placeables[i]
		else:
			get_child(i).queue_free()


func _on_placeable_display_placeable_bought(placeable: Placeable) -> void:
	placeable_bought.emit(placeable)


func _process(_delta: float) -> void:
	if placeables != previous_placeables:
		update_placeable_displays()
		previous_placeables = placeables.duplicate()
