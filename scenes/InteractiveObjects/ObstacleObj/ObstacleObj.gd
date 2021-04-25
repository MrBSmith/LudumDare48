extends InteractiveObj
class_name ObstacleObj

#### ACCESSORS ####

func is_class(value: String): return value == 'ObstacleObj' or .is_class(value)
func get_class() -> String: return 'ObstacleObj'


#### BUILT-IN ####

func _ready():
	var __ = EVENTS.connect("open", self, "_on_open")

#### VIRTUALS ####

func interact() -> void:
	if $StatesMachine.get_state_name() == "Idle" && is_interactable():
		EVENTS.emit_signal("try_opening", self)

#### LOGIC ####

func _on_open(obstacle: ObstacleObj):
	if self == obstacle:
		$StatesMachine.set_state("Opened")

#### INPUTS ####


#### SIGNAL RESPONSES ####

