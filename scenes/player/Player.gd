extends KinematicBody2D

class_name Player

const CLASS_NAME = 'Player'
const SPEED = 300
const JUMP_SPEED = 400
const GRAVITY = 20

onready var state_machine = get_node("StatesMachine")

var horizontal_direction = 0
var vertical_direction = 0
var velocity := Vector2(0, 0)
var is_jumping = false;

export var ignore_gravity := false

#### ACCESSORS ####

func is_class(value: String): return value == CLASS_NAME or .is_class(value)
func get_class() -> String: return CLASS_NAME

func get_state():
	return state_machine.get_state()
	
func set_state(state: String):
	return state_machine.set_state(state)

#### BUILT-IN ####

func _physics_process(delta: float) -> void:
	if !ignore_gravity:
		velocity.y += GRAVITY

	velocity.x = horizontal_direction * SPEED

	velocity = move_and_slide(velocity, Vector2.UP)

	if is_on_floor():
		if horizontal_direction != 0:
			set_state("Move")
		else:
			set_state("Idle")

#### VIRTUALS ####



#### LOGIC ####

func jump():
	velocity.y -= JUMP_SPEED
	set_state("Fall")

#### INPUTS ####

func _unhandled_input(event: InputEvent) -> void:
	horizontal_direction = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	
	if Input.is_action_just_pressed("jump") && get_state().name in ["Idle", "Move"]:
		set_state("Jump")

#### SIGNAL RESPONSES ####

