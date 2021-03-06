extends KinematicBody2D
class_name Player

const CLASS_NAME = 'Player'
const SPEED = 300
const JUMP_SPEED = 450
const GRAVITY = 20
const MAX_FALL_SPEED = 400

onready var state_machine = get_node("StatesMachine")
onready var animated_sprite = $AnimatedSprite
onready var jump_buffer_timer = $JumpBufferTimer
onready var jump_fall_tolerence_timer = $JumpFallTolerenceTimer

var horizontal_direction = 0
var vertical_direction = 0
var velocity := Vector2(0, 0)
var is_jumping = false;

var jump_buffered : bool = false
var jump_fall_tolorence : bool = false

export var ignore_gravity := false

#### ACCESSORS ####

func is_class(value: String): return value == CLASS_NAME or .is_class(value)
func get_class() -> String: return CLASS_NAME

func get_state() -> StateBase: return state_machine.get_state()
func get_state_name() -> String: return state_machine.get_state_name()

func set_state(state: String): return state_machine.set_state(state)

#### BUILT-IN ####

func _ready() -> void:
	var __ = EVENTS.connect("collect", self, "_on_collect")
	__ = jump_buffer_timer.connect("timeout", self, "_on_jump_buffer_timer_timeout")
	__ = jump_fall_tolerence_timer.connect("timeout", self, "_on_jump_fall_tolerence_timer_timeout")


func _physics_process(_delta: float) -> void:
	if !ignore_gravity:
		velocity.y += GRAVITY
		velocity.y = clamp(velocity.y, -INF, MAX_FALL_SPEED)

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
	
	if Input.is_action_just_pressed("jump"):
		if get_state_name() in ["Idle", "Move"]:
			set_state("Jump")
		
		elif get_state_name() == "Fall":
			if jump_fall_tolorence && $StatesMachine.previous_state.name in ["Idle", "Move"]:
				set_state("Jump")
			else:
				jump_buffered = true
				jump_buffer_timer.start()


#### SIGNAL RESPONSES ####

func _on_collect(_item: Item) -> void:
	# @TODO add animation
	pass

func _on_jump_buffer_timer_timeout():
	jump_buffered = false

func _on_jump_fall_tolerence_timer_timeout():
	jump_fall_tolorence = false
