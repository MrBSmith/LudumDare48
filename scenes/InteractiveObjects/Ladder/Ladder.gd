extends InteractiveObj
class_name Ladder

#### ACCESSORS ####

func is_class(value: String): return value == "Ladder" or .is_class(value)
func get_class() -> String: return "Ladder"


#### BUILT-IN ####



#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("action") && player_in_area:
		EVENTS.emit_signal("increment_level_variation")


#### SIGNAL RESPONSES ####
