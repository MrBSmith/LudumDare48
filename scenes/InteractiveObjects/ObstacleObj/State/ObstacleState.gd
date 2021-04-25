extends StateBase

class_name ObstacleState

onready var animated_sprite = get_node_or_null("AnimatedSprite")

#### ACCESSORS ####

func is_class(value: String): return value == 'ObstacleState' or .is_class(value)
func get_class() -> String: return 'ObstacleState'

#### BUILT-IN ####

func enter_state():
	if animated_sprite == null:
		return

	var frames : SpriteFrames = animated_sprite.get_sprite_frames()
	
	if frames == null:
		return

	if frames.has_animation(name):
		animated_sprite.play(name)

#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####
