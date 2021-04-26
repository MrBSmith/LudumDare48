extends InteractiveObj
class_name ObstacleObj

onready var is_animated : bool = get_node_or_null("AnimatedSprite") != null

#### ACCESSORS ####

func is_class(value: String): return value == 'ObstacleObj' or .is_class(value)
func get_class() -> String: return 'ObstacleObj'

signal is_consumed(obstable)

#### BUILT-IN ####

func _ready():
	var __ = EVENTS.connect("interaction_succeed", self, "_on_interaction_succeed")
	__ = $StatesMachine.connect("state_changed", self, "_on_state_changed")

#### VIRTUALS ####

func interact() -> void:
	if $StatesMachine.get_state_name() == "Idle" && is_interactable():
		EVENTS.emit_signal("try_interact", self)

#### LOGIC ####

#### INPUTS ####


#### SIGNAL RESPONSES ####

func _on_interaction_succeed(obj: InteractiveObj) -> void:
	if obj == self:
		$StatesMachine.set_state("Opening")

func _on_state_changed(state_name: String) -> void:
	if state_name == "Opened":
		EVENTS.emit_signal("recede_interactable", self) # force exiting area to handle inventory visibility
		emit_signal("is_consumed", self)
