extends KinematicBody2D

class_name Player

const CLASS_NAME = 'Player'
const SPEED = 300
const JUMP_SPEED = 400
const GRAVITY = 20

var horizontal_direction = 0
var vertical_direction = 0
var velocity := Vector2(0, 0)
var is_jumping = false;

export var ignore_gravity := false

#### ACCESSORS ####

func is_class(value: String): return value == CLASS_NAME or .is_class(value)
func get_class() -> String: return CLASS_NAME

#### BUILT-IN ####

func _physics_process(delta: float) -> void:
	if !ignore_gravity:
		velocity.y += GRAVITY

	velocity.x = horizontal_direction * SPEED

	velocity = move_and_slide(velocity, Vector2.UP)

	if is_on_floor():
		is_jumping = false

#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####

func _unhandled_input(event: InputEvent) -> void:
	horizontal_direction = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	
	if Input.is_action_just_pressed("jump") && !is_jumping:
		_jump()
	
func _jump() -> void:
	velocity.y -= JUMP_SPEED
	is_jumping = true

#### SIGNAL RESPONSES ####

