extends CanvasLayer
class_name Inventory

const CLASS_NAME = 'Inventory'

onready var item_container = get_node("ItemContainer")

#### ACCESSORS ####

func is_class(value: String): return value == CLASS_NAME or .is_class(value)
func get_class() -> String: return CLASS_NAME

#### BUILT-IN ####

func _ready() -> void:
	var __ = EVENTS.connect("collect", self, "_on_collect")
	__ = EVENTS.connect("try_opening", self, "_on_try_opening")

#### VIRTUALS ####


#### LOGIC ####


#### INPUTS ####


#### SIGNAL RESPONSES ####

func _on_collect(item: Item) -> void:
	var newItem: Item = item.duplicate()
	newItem.set_position(Vector2.ZERO)
	newItem.set_hidden(false)
	item_container.add_item(newItem)

func _on_try_opening(obstable: ObstacleObj) -> void:
	match obstable.get_class():
		"Chest":
			if item_container.has_item("Key"):
				EVENTS.emit_signal("open", obstable)
