tool
extends Node2D
class_name Level

onready var transition_node = $Transition
onready var states_machine = $StatesMachine

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
	transition_node.fade()


func increment_variation(increment: int = 1):
	fade_transition()
	yield(transition_node, "transition_middle")
	states_machine.increment_state(increment)
	yield(transition_node, "transition_finished")
	$Player.set_global_position($EntryPoint.get_global_position())


#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_increment_level_variation():
	increment_variation(1)

func _on_decrement_level_variation():
	increment_variation(-1)
