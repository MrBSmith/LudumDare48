extends CanvasLayer
class_name FadeTransition

enum FADE_MODE {FADE_IN_OUT, FADE_IN, FADE_OUT}

onready var tween = $Tween

signal transition_finished
signal transition_middle

#### ACCESSORS ####

func is_class(value: String): return value == "FadeTransition" or .is_class(value)
func get_class() -> String: return "FadeTransition"


#### BUILT-IN ####



#### VIRTUALS ####



#### LOGIC ####

func fade(fade_time: float = 1.0, fade_mode: int = FADE_MODE.FADE_IN_OUT, delay : float = 0.0) -> void:
	var duration = fade_time / 2 if fade_mode == FADE_MODE.FADE_IN_OUT else fade_time
	
	if fade_mode != FADE_MODE.FADE_IN:
		tween.interpolate_property($ColorRect, "color", Color(0,0,0,0), Color.black,
					 duration, Tween.TRANS_LINEAR, Tween.EASE_IN, delay)
		
		tween.start()
		yield(tween, "tween_all_completed")
		emit_signal("transition_middle")
	
	if fade_mode != FADE_MODE.FADE_OUT:
		tween.interpolate_property($ColorRect, "color", Color.black, Color(0,0,0,0),
					 duration, Tween.TRANS_LINEAR, Tween.EASE_OUT, delay)
		
		tween.start()
		yield(tween, "tween_all_completed")
	
	emit_signal("transition_finished")


func set_to_black() -> void:
	$ColorRect.set_frame_color(Color.black)



#### INPUTS ####



#### SIGNAL RESPONSES ####
