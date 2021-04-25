extends KinematicBody2D
class_name Player

const CLASS_NAME = 'Player'
const SPEED = 300
const JUMP_SPEED = 400
const GRAVITY = 20

onready var state_machine = get_node("StatesMachine")
onready var animated_sprite = $AnimatedSprite

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

func _ready() -> void:
	var __ = EVENTS.connect("collect", self, "_on_collect")


func _physics_process(_delta: float) -> void:
	if !ignore_gravity:
		velocity.y += GRAVITY

	velocity.x = horizontal_direction * SPEED

	velocity = move_and_slide(velocity, Vector2.UP)


#### VIRTUALS ####



#### LOGIC ####

func jump():
	velocity.y -= JUMP_SPEED


#### INPUTS ####

func _unhandled_input(_event: InputEvent) -> void:
	horizontal_direction = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	
	if horizontal_direction == -1:
		animated_sprite.set_flip_h(true)
	elif horizontal_direction == 1:
		animated_sprite.set_flip_h(false)
	
	if Input.is_action_just_pressed("jump") && get_state().name in ["Idle", "Move"]:
		set_state("Jump")

#### SIGNAL RESPONSES ####

func _on_collect(_item: Item) -> void:
	# @TODO add animation
	pass
