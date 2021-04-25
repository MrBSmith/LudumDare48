extends CanvasLayer
class_name Inventory

const CLASS_NAME = 'Inventory'

onready var item_container = get_node("ItemContainer")
onready var tween = $Tween

onready var hidden_pos = item_container.get_position()
onready var visible_pos = hidden_pos + Vector2(0, get_node("ItemContainer/TextureRect").get_size().y)

var hidden : bool = true setget set_hidden, is_hidden
var transitioning : bool = false


#### ACCESSORS ####

func is_class(value: String): return value == CLASS_NAME or .is_class(value)
func get_class() -> String: return CLASS_NAME

func set_hidden(value: bool):
	if hidden != value:
		hidden = value
		transition(hidden)

func is_hidden() -> bool: return hidden


#### BUILT-IN ####

func _ready() -> void:
	var __ = EVENTS.connect("collect", self, "_on_collect")
	__ = EVENTS.connect("try_opening", self, "_on_try_opening")
	tween.connect("tween_all_completed", self, "_on_tween_all_completed")


#### VIRTUALS ####




#### LOGIC ####

func transition(hide: bool, instant: bool = false):
	var from = item_container.get_position()
	var to = hidden_pos if hide else visible_pos
	
	if !instant:
		tween.interpolate_property(item_container, "rect_position", 
				from, to, 1.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		
		tween.start()
		transitioning = true
	else:
		item_container.set_position(to)


#### INPUTS ####

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_HUD"):
		set_hidden(!is_hidden())


#### SIGNAL RESPONSES ####

func _on_collect(item: Item) -> void:
	var newItem: Item = item.duplicate()
	newItem.set_position(Vector2.ZERO)
	newItem.set_hidden(false)
	newItem.set_spectral(false)
	item_container.add_item(newItem)


func _on_try_opening(obstable: ObstacleObj) -> void:
	match obstable.get_class():
		"Chest":
			var item : Item = item_container.get_item("Key")
			if item != null:
				item.destroy()
				yield(item, "tree_exited")
				EVENTS.emit_signal("open", obstable)

func _on_tween_all_completed():
	transitioning = false
