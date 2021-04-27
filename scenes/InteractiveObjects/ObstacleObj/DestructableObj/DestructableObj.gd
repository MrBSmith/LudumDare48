extends ObstacleObj
class_name DestructableObj

export var nb_debris : int = 30

#### ACCESSORS ####

func is_class(value: String): return value == "DestructableObj" or .is_class(value)
func get_class() -> String: return "DestructableObj"


#### BUILT-IN ####



#### VIRTUALS ####



#### LOGIC ####

func destroy():
	EVENTS.emit_signal("scatter_object", self, 30)
	.destroy()

#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_interaction_succeed(obj: InteractiveObj):
	._on_interaction_succeed(obj)
	if obj == self:
		EVENTS.emit_signal("play_sound_effect", $AudioStreamPlayer)


func _on_state_changed(state_name: String) -> void:
	._on_state_changed(state_name)
	if state_name == "Opened":
		destroy()
