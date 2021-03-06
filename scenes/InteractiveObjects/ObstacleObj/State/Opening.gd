extends ObstacleState
class_name Opening

const CLASS_NAME = 'Opening'

#### ACCESSORS ####

func is_class(value: String): return value == CLASS_NAME or .is_class(value)
func get_class() -> String: return CLASS_NAME

#### BUILT-IN ####



#### VIRTUALS ####

func enter_state():
	.enter_state()
	if animated_sprite == null:
#		states_machine.increment_state()
		states_machine.set_state("Opened")

#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_animation_finished():
	if is_current_state():
		states_machine.set_state("Opened")
