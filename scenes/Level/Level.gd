tool
extends Node2D
class_name Level

onready var transition_node = $Transition
onready var states_machine = $StatesMachine

export var transition_duration_in : float = 0.5
export var transition_duration_out : float = 0.3
export var transition_delay : float = 0.7

#### ACCESSORS ####

func is_class(value: String): return value == "Level" or .is_class(value)
func get_class() -> String: return "Level"


#### BUILT-IN ####

func _ready() -> void:
	var __ = EVENTS.connect("increment_level_variation", self, "_on_increment_level_variation")
	__ = EVENTS.connect("decrement_level_variation", self, "_on_decrement_level_variation")
	__ = EVENTS.connect("next_level_query", self, "_on_next_level_query")
	
	transition_node.set_to_black()
	transition_node.fade(transition_duration_in, transition_node.FADE_MODE.FADE_IN, transition_delay)

#### VIRTUALS ####



#### LOGIC ####

func get_interactives() -> Array:
	var objects_array = []
	for child in get_children():
		if child is InteractiveObj:
			objects_array.append(child)
	return objects_array


func increment_variation(increment: int = 1):
	transition_node.fade(transition_duration_in)
	yield(transition_node, "transition_middle")
	states_machine.increment_state(increment)
	yield(transition_node, "transition_finished")
	$Player.set_global_position($EntryPoint.get_global_position())

func go_to_next_level():
	transition_node.fade(transition_duration_out, transition_node.FADE_MODE.FADE_OUT)
	yield(transition_node, "transition_finished")
	EVENTS.emit_signal("go_to_next_level")

#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_increment_level_variation():
	increment_variation(1)

func _on_decrement_level_variation():
	increment_variation(-1)

func _on_next_level_query():
	go_to_next_level()
