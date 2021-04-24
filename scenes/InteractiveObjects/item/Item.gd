extends InteractiveObj
class_name Item
const CLASS_NAME = 'Item'

var in_inventory = false
var is_collected = false

#### ACCESSORS ####

func is_class(value: String): return value == CLASS_NAME or .is_class(value)
func get_class() -> String: return CLASS_NAME

#### BUILT-IN ####



#### VIRTUALS ####



#### LOGIC ####

func interact():
	pass

#### INPUTS ####

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("action") && player_in_area && !is_collected:
		is_collected = true
		EVENTS.emit_signal("collect", self)
		queue_free()

#### SIGNAL RESPONSES ####

