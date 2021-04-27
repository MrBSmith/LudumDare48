extends ActorStateBase

class_name Fall

const CLASS_NAME = 'Fall'

#### ACCESSORS ####

func is_class(value: String): return value == CLASS_NAME or .is_class(value)
func get_class() -> String: return CLASS_NAME


#### BUILT-IN ####



#### VIRTUALS ####

func enter_state():
	owner.jump_fall_tolorence = true
	owner.jump_fall_tolerence_timer.start()


func update_state(_delta: float):
	if owner.is_on_floor():
		return "Land"

#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####
