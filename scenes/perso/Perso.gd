extends KinematicBody2D

class_name Perso

const CLASS_NAME = 'Perso'
const SPEED = 300
var horizontal_direction = 0
var velocity := Vector2(0, 0)

#### ACCESSORS ####

func is_class(value: String): return value == CLASS_NAME or .is_class(value)
func get_class() -> String: return CLASS_NAME

#### BUILT-IN ####

func _physics_process(delta: float) -> void:
	velocity.x = horizontal_direction * SPEED
	velocity = move_and_slide(velocity)

#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####

func _unhandled_input(event: InputEvent) -> void:
	horizontal_direction = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))

#### SIGNAL RESPONSES ####
