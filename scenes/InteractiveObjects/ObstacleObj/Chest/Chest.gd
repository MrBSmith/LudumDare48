tool
extends ObstacleObj
class_name Chest

const CLASS_NAME = 'Chest'

export var tresure_name : String = "Bomb"

onready var tresure_path : String = "res://scenes/InteractiveObjects/Item/" + tresure_name + "/" + tresure_name + ".tscn"
onready var tresure_scene = load(tresure_path)

#### ACCESSORS ####

func is_class(value: String): return value == CLASS_NAME or .is_class(value)
func get_class() -> String: return CLASS_NAME


#### BUILT-IN ####



#### VIRTUALS ####



#### LOGIC ####

func _on_open(obstacle: ObstacleObj):
	._on_open(obstacle)
	EVENTS.emit_signal("collect", tresure_scene.instance())

#### INPUTS ####



#### SIGNAL RESPONSES ####
