extends Node2D

const MIN_ROPE_LENGTH = 200.0

@export var loop_path: LoopPath
@export var locomotive: Locomotive
@export var loop_button: BaseButton
@export var crossfader_animation_player: AnimationPlayer


func _on_loop_started() -> void:
	locomotive.is_active = true
	crossfader_animation_player.play("unchill")


func _on_loop_stopped() -> void:
	locomotive.is_active = false
	crossfader_animation_player.play("chill")


func _on_loop_path_loop_closed():
	if loop_path.get_rope_length() > MIN_ROPE_LENGTH:
		loop_button.disabled = false
		loop_button.modulate = Color.WHITE


func _on_loop_path_loop_opened():
	loop_button.disabled = true
	loop_button.modulate = Color.DIM_GRAY


func _on_loop_button_toggled(toggled_on: bool) -> void:
	Globals.looping = toggled_on


func _ready():
	Globals.loop_started.connect(_on_loop_started)
	Globals.loop_stopped.connect(_on_loop_stopped)
