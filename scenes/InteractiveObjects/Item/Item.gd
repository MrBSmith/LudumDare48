extends InteractiveObj
class_name Item

var is_collected = false

#### ACCESSORS ####

func is_class(value: String): return value == 'Item' or .is_class(value)
func get_class() -> String: return 'Item'

#### BUILT-IN ####



#### VIRTUALS ####



#### LOGIC ####

#### INPUTS ####

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("action") && player_in_area && !is_collected:
		is_collected = true
		EVENTS.emit_signal("collect", self)
		queue_free()

#### SIGNAL RESPONSES ####

