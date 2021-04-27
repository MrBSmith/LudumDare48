extends ActorStateBase

class_name Jump

const CLASS_NAME = 'Jump'

#### ACCESSORS ####

func is_class(value: String): return value == CLASS_NAME or .is_class(value)
func get_class() -> String: return CLASS_NAME

#### BUILT-IN ####



#### VIRTUALS ####

func enter_state():
	.enter_state()
	owner.jump()

#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_animation_finished():
	if is_current_state():
		states_machine.set_state("Fall")
