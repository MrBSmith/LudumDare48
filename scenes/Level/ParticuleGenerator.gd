extends Node2D
class_name ParticuleGenerator

var particule_scene = preload("res://scenes/InteractiveObjects/SpectalParticule.tscn")

#### ACCESSORS ####

func is_class(value: String): return value == "ParticuleGenerator" or .is_class(value)
func get_class() -> String: return "ParticuleGenerator"


#### BUILT-IN ####

func _ready() -> void:
	var __ = EVENTS.connect("invisible_spectral_obj_entered", self, "_on_invisible_spectral_obj_entered")


#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_invisible_spectral_obj_entered(obj: InteractiveObj, player_velocity_dir: Vector2) -> void:
	pass
