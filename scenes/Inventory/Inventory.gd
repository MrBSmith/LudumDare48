extends CanvasLayer
class_name Inventory

const CLASS_NAME = 'Inventory'

onready var item_container = get_node("ItemContainer")
onready var tween = $Tween
onready var timer = $Timer

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
	__ = EVENTS.connect("try_interact", self, "_on_try_interact")
	__ = EVENTS.connect("approch_interactable", self, "_on_approch_interactable")
	__ = EVENTS.connect("recede_interactable", self, "_on_recede_interactable")
	__ = tween.connect("tween_all_completed", self, "_on_tween_all_completed")
	__ = timer.connect("timeout", self, "_on_timer_timeout")


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
	var new_item: Item = item.duplicate() if item.is_inside_tree() else item
	new_item.set_position(Vector2.ZERO)
	new_item.set_hidden(false)
	new_item.set_spectral(false)
	new_item.set_collected(true)
	item_container.add_item(new_item)


func _on_try_interact(obstable: ObstacleObj) -> void:
	var needed_item : String = ""
	var obstacle_type = obstable.get_class()
	
	match(obstacle_type):
		"Chest": needed_item = "Key"
		"Crumble": needed_item = "Pickaxe"
	
	var item : Item = item_container.get_item(needed_item)
	if item != null:
		item.destroy()
		yield(item, "tree_exited")
		item_container.refresh_items_display()
		EVENTS.emit_signal("interaction_succeed", obstable)


func _on_tween_all_completed():
	transitioning = false

func _on_approch_interactable(_obj: InteractiveObj):
	set_hidden(false)

func _on_recede_interactable(_obj: InteractiveObj):
	timer.start()

func _on_timer_timeout():
	if !is_hidden():
		set_hidden(true)
