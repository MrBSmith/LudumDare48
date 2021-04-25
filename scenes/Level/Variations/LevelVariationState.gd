tool
extends StateBase
class_name LevelVariationState

export var sky_color := Color("5ea6b9")
export var hidden_obj_array : Array = []

#### ACCESSORS ####

func is_class(value: String): return value == "LevelVariationState" or .is_class(value)
func get_class() -> String: return "LevelVariationState"


#### BUILT-IN ####

func enter_state() -> void:
	var interactives = owner.get_interactives()
	
	for obj in interactives:
		var str_path = str(obj.get_path()).replacen("/root/Level/", "")
		obj.set_hidden(str_path in hidden_obj_array)
	
	owner.get_node("Background/ColorRect").set_frame_color(sky_color)


#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####
