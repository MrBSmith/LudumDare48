extends CanvasLayer

class_name Inventory

const CLASS_NAME = 'Inventory'

onready var control = get_node("Control")

#### ACCESSORS ####

func is_class(value: String): return value == CLASS_NAME or .is_class(value)
func get_class() -> String: return CLASS_NAME

#### BUILT-IN ####

func _ready() -> void:
	EVENTS.connect("collect", self, "_on_collect")

func _physics_process(delta: float) -> void:
	pass;

#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_collect(item: Item) -> void:
	var newItem: Item = item.duplicate()
	newItem.set_position(Vector2.ZERO)
	control.add_item(newItem)
