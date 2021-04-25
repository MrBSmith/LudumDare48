tool
extends InteractiveObj
class_name Item

var is_collected = false

#### ACCESSORS ####

func is_class(value: String): return value == 'Item' or .is_class(value)
func get_class() -> String: return 'Item'

#### BUILT-IN ####



#### VIRTUALS ####

func interact() -> void:
	if _is_collectable():
		is_collected = true
		EVENTS.emit_signal("collect", self)
		queue_free()

#### LOGIC ####

func destroy() -> void:
	queue_free()

func _is_collectable() -> bool:
	return !is_collected && is_interactable()

#### INPUTS ####


#### SIGNAL RESPONSES ####

