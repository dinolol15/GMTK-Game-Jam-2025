@tool
class_name AudioStreamCrossfader
extends Node

@export_range(0.0, 1.0) var mix := 0.0:
	set(value):
		mix = value
		audio_stream_player_1.volume_linear = cos(mix * PI / 2.0)
		audio_stream_player_2.volume_linear = sin(mix * PI / 2.0)

@export var audio_stream_player_1: AudioStreamPlayer
@export var audio_stream_player_2: AudioStreamPlayer
