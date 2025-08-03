extends Node2D

const MIN_ROPE_LENGTH = 200.0

@export var loop_path: LoopPath
@export var locomotive: Locomotive
@export var placeable_root: Node2D
@export var loop_button: BaseButton
@export var store_animation_player: AnimationPlayer
@export var crossfader_animation_player: AnimationPlayer

static var station_dragger_scene = preload("res://scenes/station_dragger.tscn")


func _on_loop_started() -> void:
	locomotive.is_active = true
	store_animation_player.play("disappear")
	crossfader_animation_player.play("unchill")


func _on_loop_stopped() -> void:
	locomotive.is_active = false
	store_animation_player.play("appear")
	crossfader_animation_player.play("chill")


func _on_loop_path_loop_closed():
	if loop_path.get_rope_length() > MIN_ROPE_LENGTH:
		loop_button.disabled = false
		loop_button.modulate = Color.WHITE


func _on_loop_path_loop_opened():
	loop_button.disabled = true
	loop_button.modulate = Color.DIM_GRAY


func _on_train_speed_slider_value_changed(value: float) -> void:
	locomotive.speed = value


func _on_loop_button_toggled(toggled_on: bool) -> void:
	Globals.looping = toggled_on


func _on_debug_button_pressed():
	for cargo in Storage.cargo_storage:
		Storage.add_cargo(cargo, 999)


func _on_placeable_bought(placeable: Placeable) -> void:
	var new_object = placeable.scene.instantiate()
	if new_object is not Draggable:
		var station_dragger = station_dragger_scene.instantiate()
		station_dragger.add_child(new_object)
		new_object = station_dragger
	new_object.dragging = true
	placeable_root.add_child(new_object)
	new_object.global_position = get_global_mouse_position()


func _ready() -> void:
	Globals.loop_started.connect(_on_loop_started)
	Globals.loop_stopped.connect(_on_loop_stopped)
