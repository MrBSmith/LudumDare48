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
var last_interactive_obj_encountered : InteractiveObj = null

#### ACCESSORS ####

func is_class(value: String): return value == CLASS_NAME or .is_class(value)
func get_class() -> String: return CLASS_NAME

func set_hidden(value: bool):
	if hidden != value:
		hidden = value
		transition(hidden)

func is_hidden() -> bool: return hidden

func is_transitioning() -> bool: return transitioning

func set_transitioning(value: bool):
		transitioning = value

#### BUILT-IN ####

func _ready() -> void:
	var __ = EVENTS.connect("collect", self, "_on_collect")
	__ = EVENTS.connect("try_interact", self, "_on_try_interact")
	__ = EVENTS.connect("approch_interactable", self, "_on_approch_interactable")
	__ = EVENTS.connect("recede_interactable", self, "_on_recede_interactable")
	__ = tween.connect("tween_all_completed", self, "_on_tween_all_completed")

#### VIRTUALS ####


#### LOGIC ####

func transition(hide: bool, instant: bool = false):
	var from = item_container.get_position()
	var to = hidden_pos if hide else visible_pos
	
	if !instant:
		tween.interpolate_property(item_container, "rect_position", 
				from, to, 1.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		
		tween.start()
		set_transitioning(true)
	else:
		item_container.set_position(to)

#### INPUTS ####

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_HUD"):
		set_hidden(!is_hidden())

#### SIGNAL RESPONSES ####

func _on_collect(item: Item) -> void:
	if item == last_interactive_obj_encountered: # @TODO remove ?
		last_interactive_obj_encountered = null

	var new_item: Item = item.duplicate() if item.is_inside_tree() else item
	new_item.connect("glow_up_finished", self, "_glow_up_finished")
	_show()

	if is_transitioning(): # @TODO and visible
		yield(tween, "tween_all_completed")

	_add_item(new_item)

	if !new_item.is_ready: yield(new_item, "ready") # waiting for new_item to be ready

	new_item.glow_up()


func _on_try_interact(obstable: ObstacleObj) -> void:
	# first, we check if we have the item needed to interect with the current obstable
	var needed_item_name : String = ""

	match(obstable.get_class()):
		"Chest": needed_item_name = "Key"
		"Crumble": needed_item_name = "Pickaxe"
	var item : Item = item_container.get_item(needed_item_name)

	if item != null: # interaction succeed
		_remove_item(item)
		EVENTS.emit_signal("interaction_succeed", obstable)
	else: # interaction failed
		EVENTS.emit_signal("interaction_failed", obstable)

func _on_tween_all_completed():
	set_transitioning(false)

func _on_approch_interactable(obj: InteractiveObj):
	last_interactive_obj_encountered = obj
	_show()

func _on_recede_interactable(obj: InteractiveObj):
	if obj == last_interactive_obj_encountered:
		last_interactive_obj_encountered = null
		_hide()

func _add_item(item: Item) -> void:
	item.set_position(Vector2.ZERO)
	item.set_hidden(false)
	item.set_spectral(false)
	item.set_collected(true)
	item_container.add_item(item)

func _remove_item(item: Item) -> void:
	if is_transitioning():
		yield(tween, "tween_all_completed")
		item.destroy()
		yield(item, "tree_exited")
		item_container.refresh_items_display()

func _hide() -> void:
	if timer.is_stopped() && last_interactive_obj_encountered == null:
		set_hidden(true)

func _show() -> void:
	set_hidden(false)
	
func _glow_up_finished(item: Item) -> void:
	item.disconnect("glow_up_finished", self, "_glow_up_finished")
	
	timer.start()
	yield(timer, "timeout")

	_hide()
