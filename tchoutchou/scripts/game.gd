extends Node2D

const MIN_ROPE_LENGTH = 200.0

@export var loop_path: LoopPath
@export var loop_button: BaseButton
@export var crossfader_animation_player: AnimationPlayer

var looping = false


func _on_loop_path_loop_closed():
	if loop_path.get_rope_length() > MIN_ROPE_LENGTH:
		loop_button.disabled = false
		loop_button.modulate = Color.WHITE


func _on_loop_path_loop_opened():
	loop_button.disabled = true
	loop_button.modulate = Color.DIM_GRAY


func _on_loop_button_toggled(toggled_on: bool) -> void:
	looping = toggled_on
	crossfader_animation_player.play("unchill" if looping else "chill")
