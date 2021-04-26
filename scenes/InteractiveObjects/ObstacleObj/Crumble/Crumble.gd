tool
extends ObstacleObj
class_name Crumble

#### ACCESSORS ####

func is_class(value: String): return value == "Crumble" or .is_class(value)
func get_class() -> String: return "Crumble"


#### BUILT-IN ####



#### VIRTUALS ####

func interact() -> void:
	if $StatesMachine.get_state_name() == "Idle" && is_interactable():
		EVENTS.emit_signal("try_interact", self)


#### LOGIC ####

func destroy():
	queue_free()

#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_interaction_succeed(obj: InteractiveObj):
	if obj == self:
		EVENTS.emit_signal("scatter_object", self, 30.0)
		$CollisionShape2D.set_disabled(true)
		$Sprite.set_visible(false)
		$AudioStreamPlayer.play()
		yield($AudioStreamPlayer, "finished")
		
		destroy()
