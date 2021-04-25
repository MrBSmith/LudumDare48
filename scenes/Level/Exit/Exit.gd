extends Area2D
class_name LevelExit

#### ACCESSORS ####

func is_class(value: String): return value == "LevelExit" or .is_class(value)
func get_class() -> String: return "LevelExit"


#### BUILT-IN ####

func _ready() -> void:
	var __ = connect("body_entered", self, "_on_body_entered")

#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_body_entered(body: Node):
	if body is Player:
		EVENTS.emit_signal("increment_level_variation")
