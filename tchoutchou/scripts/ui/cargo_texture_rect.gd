@tool
class_name CargoTextureRect
extends TextureRect

@export var cargo: Globals.Cargo:
	set(value):
		cargo = value
		var frame = Globals.CARGO_FRAMES[cargo]
		@warning_ignore("integer_division")
		texture.region.position = Vector2(frame % 11, frame / 11) * 24.0


func _ready() -> void:
	texture = texture.duplicate()
