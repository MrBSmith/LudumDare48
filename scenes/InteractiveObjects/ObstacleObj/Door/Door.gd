extends ObstacleObj
class_name Door

#### ACCESSORS ####

func is_class(value: String): return value == "Door" or .is_class(value)
func get_class() -> String: return "Door"

func set_hidden(value: bool) -> void:
	.set_hidden(value)
	$CollisionShape2D.set_disabled(value)

#### BUILT-IN ####

func _ready() -> void:
	var __ = $ExitLevelArea.connect("body_entered", self, "_on_exit_area_body_entered")



#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_state_changed(state: StateBase):
	._on_state_changed(state)
	if state.name == "Opened":
		$CollisionShape2D.set_disabled(true)
	elif state.name == "Idle":
		$CollisionShape2D.set_disabled(false)


func _on_body_entered(body: Node):
	if body.is_class("Player") && $StatesMachine.get_state_name() == "Idle"\
		&& is_interactable():
		$StatesMachine.set_state("Opening")


func _on_body_exited(body: Node):
	if body.is_class("Player") && $StatesMachine.get_state_name() == "Opened"\
		&& is_interactable():
		$StatesMachine.set_state("Closing")


func _on_exit_area_body_entered(body: Node):
	if body.is_class("Player") && $StatesMachine.get_state_name() == "Opened"\
		&& is_interactable():
		EVENTS.emit_signal("next_level_query")
