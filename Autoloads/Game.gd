extends Node

#### GAME AUTOLOAD ####

export var menu_dict : Dictionary = {
	"ScreenTitle": preload("res://scenes/Menu/ScreenTitle/ScreenTitle.tscn"),
	"InputMenu": preload("res://scenes/Menu/Controls/InputMenu.tscn")
}

export var level_path_array : Array = [
	"res://scenes/Level/Instances/Level1.tscn",
	"res://scenes/Level/Instances/Level2.tscn",
	"res://scenes/Level/Instances/Level3.tscn",
	"res://scenes/Level/Instances/Level4.tscn",
	"res://scenes/Level/Instances/Level5.tscn",
	"res://scenes/Level/Instances/LastLevel.tscn"
]

var current_level_id : int = 0

func _ready() -> void:
	var __ = EVENTS.connect("go_to_next_level", self, "_on_go_to_next_level")
	__ = EVENTS.connect("go_to_level", self, "_on_go_to_level")


#### LOGIC ####

func generate_menu(menu_type: String) -> MenuBase:
	if !menu_type in menu_dict.keys():
		push_error("The given menu type " + menu_type + "doesn't exist in the MENU_DICT")
		return null
	
	return menu_dict[menu_type].instance()


func generate_level(level_id: int) -> Level:
	if level_id > level_path_array.size() - 1:
		push_error("The given level_id " + String(level_id) + " is out of bound of the level_path_array")
		return null
	
	return level_path_array[level_id].instance()


func go_to_current_level():
	var level_scene = load(level_path_array[current_level_id])
	var __ = get_tree().change_scene_to(level_scene)


#### SIGNAL RESPONSES ####

func _on_go_to_next_level():
	current_level_id = wrapi(current_level_id + 1, 0, level_path_array.size())
	go_to_current_level()


func _on_go_to_level(level_id: int):
	current_level_id = level_id
	go_to_current_level()
