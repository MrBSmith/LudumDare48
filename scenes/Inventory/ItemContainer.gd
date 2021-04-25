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
	item.position.x = (slot_x * count_items()) + (slot_x / 2)
	item.position.y = rect_size.y / 2
	add_child(item)
	item.owner = owner


func count_items() -> int:
	var count = 0
	for child in get_children():
		if child is Item:
			count += 1
	return count

func get_item(item_name: String) -> Item:
	for child in get_children():
		if child.is_class(item_name):
			return child
	return null

func get_items() -> Array:
	var items_array = []
	for child in get_children():
		if child is Item:
			items_array.append(child)
	return items_array

#### INPUTS ####


#### SIGNAL RESPONSES ####
