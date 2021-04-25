extends Node2D
class_name Level

#### ACCESSORS ####

func is_class(value: String): return value == "Level" or .is_class(value)
func get_class() -> String: return "Level"


#### BUILT-IN ####

func _ready() -> void:
	var __ = EVENTS.connect("increment_level_variation", self, "_on_increment_level_variation")
	__ = EVENTS.connect("decrement_level_variation", self, "_on_decrement_level_variation")

#### VIRTUALS ####



#### LOGIC ####

func get_interactives() -> Array:
	var objects_array = []
	for child in get_children():
		if child is InteractiveObj:
			objects_array.append(child)
	return objects_array


func fade_transition():
	$FadeTransition.fade()


#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_increment_level_variation():
	$StatesMachine.increment_state()
	fade_transition()

func _on_decrement_level_variation():
	$StatesMachine.increment_state(-1)
	fade_transition()
