extends Node2D
class_name SoundEffectsHandler

#### ACCESSORS ####

func is_class(value: String): return value == "SoundEffectsHandler" or .is_class(value)
func get_class() -> String: return "SoundEffectsHandler"


#### BUILT-IN ####

func _ready() -> void:
	var __ = EVENTS.connect("play_sound_effect", self, "_on_play_sound_effect")

#### VIRTUALS ####



#### LOGIC ####

func play(stream_player : AudioStreamPlayer):
	var new_stream_player = stream_player.duplicate()
	call_deferred("add_child", new_stream_player)
	new_stream_player.call_deferred("play")
	
	yield(new_stream_player, "finished")
	new_stream_player.queue_free()


#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_play_sound_effect(stream_player: AudioStreamPlayer):
	play(stream_player)
