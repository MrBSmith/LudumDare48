extends StateBase

class_name ObstacleState

onready var animated_sprite = owner.get_node_or_null("AnimatedSprite")

#### ACCESSORS ####

func is_class(value: String): return value == 'ObstacleState' or .is_class(value)
func get_class() -> String: return 'ObstacleState'

#### BUILT-IN ####

func _ready() -> void:
	if animated_sprite != null:
		var __ = animated_sprite.connect("animation_finished", self, "_on_animation_finished")

#### VIRTUALS ####


func enter_state():
	if animated_sprite == null:
		return

	var frames : SpriteFrames = animated_sprite.get_sprite_frames()
	
	if frames == null:
		return

	if frames.has_animation(name):
		animated_sprite.play(name)

#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_animation_finished():
	pass
