extends Particles2D
class_name SpectralParticule

var is_ready = false

#### ACCESSORS ####

func is_class(value: String): return value == "SpectralParticule" or .is_class(value)
func get_class() -> String: return "SpectralParticule"


#### BUILT-IN ####

func _ready() -> void:
	is_ready = true
	set_emitting(true)
	var __ = $Timer.connect("timeout", self, "_on_timer_timeout")


#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_timer_timeout():
	queue_free()
