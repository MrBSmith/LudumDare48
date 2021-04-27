extends ObstacleState
class_name Closing

#### ACCESSORS ####

func is_class(value: String): return value == "Closing" or .is_class(value)
func get_class() -> String: return "Closing"


#### BUILT-IN ####



#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_animation_finished():
	if is_current_state():
		states_machine.set_state("Idle")
