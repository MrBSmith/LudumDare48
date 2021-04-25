extends CanvasLayer
class_name FadeTransition

onready var tween = $Tween

signal transition_finished

#### ACCESSORS ####

func is_class(value: String): return value == "FadeTransition" or .is_class(value)
func get_class() -> String: return "FadeTransition"


#### BUILT-IN ####



#### VIRTUALS ####



#### LOGIC ####

func fade():
	tween.interpolate_property($ColorRect, "color", Color(0,0,0,0), Color.black,
				 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	
	tween.start()
	yield(tween, "tween_all_completed")
	
	tween.interpolate_property($ColorRect, "color", Color.black, Color(0,0,0,0),
				 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	
	tween.start()
	yield(tween, "tween_all_completed")
	emit_signal("transition_finished")


#### INPUTS ####



#### SIGNAL RESPONSES ####
