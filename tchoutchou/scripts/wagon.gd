@tool
class_name Wagon
extends PathFollow2D

@export var cargo := Globals.Cargo.NONE:
	set(value):
		cargo = value
		if cargo_textures.has(cargo):
			sprite.texture = cargo_textures[cargo]
		cargo_sprite.cargo = cargo
@export var is_active := false:
	set(value):
		is_active = value
		if not is_active:
			cargo = Globals.Cargo.NONE
			progress = 0.0
@export var cargo_textures: Dictionary[Globals.Cargo, Texture2D]
@export var cargo_sprite_offset := Vector2.ZERO

@export var sprite: Sprite2D
@export var cargo_sprite: CargoSprite
@export var animation_player: AnimationPlayer


func _on_area_2d_area_entered(area: Area2D) -> void:
	if Engine.is_editor_hint() or not is_active:
		return

	if area is Station:
		var old_cargo = cargo
		cargo = area.try_convert(cargo)
		animation_player.play("right_cargo" if cargo != old_cargo else "wrong_cargo")


func _process(_delta: float) -> void:
	cargo_sprite.global_position = global_position + cargo_sprite_offset
