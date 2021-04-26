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

func generate_particule(pos: Vector2, dir: Vector2):
	var particule = particule_scene.instance()
	particule.set_position(pos)
	
	add_child(particule)
	if !particule.is_ready:
		yield(particule, "ready")
	
	var particule_material = particule.get_process_material()
	particule_material.set_direction(Vector3(dir.x, dir.y, 0))


#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_invisible_spectral_obj_entered(obj: InteractiveObj, player_velocity_dir: Vector2) -> void:
	generate_particule(obj.get_position(), player_velocity_dir)
