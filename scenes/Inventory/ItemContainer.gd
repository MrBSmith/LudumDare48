extends Control

const CLASS_NAME = 'ItemContainer'

const ITEM_SIZE = Vector2(64, 64)
const MARGIN = Vector2(4, 4)

#### ACCESSORS ####

func is_class(value: String): return value == CLASS_NAME or .is_class(value)
func get_class() -> String: return CLASS_NAME


#### BUILT-IN ####


#### VIRTUALS ####


#### LOGIC ####

func add_item(item: Item) -> void:
	var half_item_x = ITEM_SIZE.x / 2
	item.position.y = rect_size.y / 2
	item.position.x = (count_items() * ITEM_SIZE.x) + half_item_x + (MARGIN.x * (count_items() + 1))
	add_child(item)

func count_items() -> int:
	var count = 0
	for child in get_children():
		if child is Item:
			count += 1

	return count

func has_item(item_name: String) -> bool:
	for child in get_children():
		if child.is_class(item_name):
			return true
	
	return false;

#### INPUTS ####


#### SIGNAL RESPONSES ####
