extends Control
const CLASS_NAME = 'ItemContainer'

onready var slot_x = rect_size.x / 3

#### ACCESSORS ####

func is_class(value: String): return value == CLASS_NAME or .is_class(value)
func get_class() -> String: return CLASS_NAME


#### BUILT-IN ####


#### VIRTUALS ####


#### LOGIC ####

func add_item(item: Item) -> void:
	_set_item_position(item, count_items())
	add_child(item)
	item.owner = owner

func count_items() -> int:
	var count = 0
	for child in get_children():
		if child is Item:
			count += 1
	return count

func get_item(item_class: String) -> Item:
	for item in get_items():
		if item.is_class(item_class):
			return item
	return null

func get_items() -> Array:
	var items_array = []
	for child in get_children():
		if child is Item:
			items_array.append(child)
	return items_array
	
func refresh_items_display() -> void:
	var items = get_items();
	for key in range(items.size()):
		var item = items[key]
		_set_item_position(item, key)

func _set_item_position(item: Item, position: int) -> void:
	item.position.x = (slot_x * position) + (slot_x / 2)
	item.position.y = rect_size.y / 2

#### INPUTS ####


#### SIGNAL RESPONSES ####
