class_name Wagon
extends PathFollow2D

@export var cargo := Globals.Cargo.NONE:
	set(value):
		cargo = value
		sprite.texture = cargo_textures[cargo]
@export var cargo_textures: Dictionary[Globals.Cargo, Texture2D]

@export var sprite: Sprite2D


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is Station:
		cargo = area.try_convert(cargo)
