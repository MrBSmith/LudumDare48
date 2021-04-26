tool
extends ObstacleObj
class_name Crumble

#### ACCESSORS ####

func is_class(value: String): return value == "Crumble" or .is_class(value)
func get_class() -> String: return "Crumble"


#### BUILT-IN ####



#### VIRTUALS ####

func interact() -> void:
	if $StatesMachine.get_state_name() == "Idle" && is_interactable():
		EVENTS.emit_signal("try_interact", self)


#### LOGIC ####


#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_interaction_succeed(obj: InteractiveObj):
	if obj == self:
		EVENTS.emit_signal("play_sound_effect", $AudioStreamPlayer)

func _on_state_changed(state_name: String) -> void:
	._on_state_changed(state_name)
	if state_name == "Opened":
		destroy()
