extends ActorStateBase
class_name Land

#### ACCESSORS ####

func is_class(value: String): return value == "Land" or .is_class(value)
func get_class() -> String: return "Land"


#### BUILT-IN ####



#### VIRTUALS ####

func enter_state():
	if owner.jump_buffered:
		states_machine.set_state("Jump")

#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_animation_finished():
	if is_current_state():
			states_machine.set_state("Idle")
