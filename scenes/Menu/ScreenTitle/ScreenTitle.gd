extends MenuBase
class_name ScreenTitle

onready var label = $Label
onready var tween = $Tween


#### ACCESSORS ####

func is_class(value: String): return value == "ScreenTitle" or .is_class(value)
func get_class() -> String: return "ScreenTitle"


#### BUILT-IN ####


func _ready() -> void:
	trigger_label_fade()



func trigger_label_fade():
	tween.interpolate_property(label, "modulate", Color.white, Color.transparent, 
						1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
						
	tween.start()
	yield(tween, "tween_all_completed")
	
	tween.interpolate_property(label, "modulate", Color.transparent, Color.white, 
						1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	tween.start()
	yield(tween, "tween_all_completed")
	trigger_label_fade()


#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("action"):
		EVENTS.emit_signal("go_to_level", 0)

#### SIGNAL RESPONSES ####

