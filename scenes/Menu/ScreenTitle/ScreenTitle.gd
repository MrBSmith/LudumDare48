extends MenuBase
class_name ScreenTitle

#### ACCESSORS ####

func is_class(value: String): return value == "ScreenTitle" or .is_class(value)
func get_class() -> String: return "ScreenTitle"


#### BUILT-IN ####



#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_menu_option_chose(option: MenuOptionsBase) -> void:
	match(option.name):
		"Play": EVENTS.emit_signal("go_to_level", 0)
		"Controls": navigate_sub_menu(GAME.generate_menu("InputMenu"))
