tool
extends InteractiveObj
class_name Item

const GLOW_UP_TIME = 0.45
const GLOW_DOWN_TIME = 0.2

onready var tween = $Tween
onready var initial_position = get_position()

var vawing_up : bool = bool(Math.randi_range(0, 1))

export var vawing_offset := Vector2(0, 3)

export var collected = false setget set_collected, is_collected

signal glow_up_finished(item)

#### ACCESSORS ####

func is_class(value: String): return value == 'Item' or .is_class(value)
func get_class() -> String: return 'Item'

func set_collected(value: bool):
	if !is_ready:
		yield(self, "ready")

	collected = value
	if collected:
		tween.remove_all()
		set_position(initial_position)
		$PulsingLight.set_visible(false)
		$CollectSound.play()

func is_collected() -> bool: return collected

#### BUILT-IN ####

func _ready() -> void:
	var __ = tween.connect("tween_all_completed", self, "_on_tween_all_completed")

	if !is_collected() && !Engine.editor_hint:
		_start_waving(vawing_up)

	if spectral:
		$PulsingLight.set_visible(false)

	is_ready = true


#### VIRTUALS ####

func interact() -> void:
	if _is_collectable():
		set_collected(true)
		EVENTS.emit_signal("collect", self)
		queue_free()

#### LOGIC ####

func _is_collectable() -> bool:
	return !is_collected() && is_interactable()


func _start_waving(up: bool = true):
	var vawing_sign = 1 if up else -1

	tween.interpolate_property(self, "position", get_position(),
		initial_position + (vawing_offset * vawing_sign),
		1.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()


func glow_up() -> void:
	var init_scale = get_scale()
	var glow_up_scale = Vector2(2, 2);
	tween.interpolate_property(self, "scale", init_scale, glow_up_scale, GLOW_UP_TIME, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_all_completed")

	tween.interpolate_property(self, "scale", glow_up_scale, init_scale, GLOW_DOWN_TIME, Tween.TRANS_CUBIC, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_all_completed")
	emit_signal("glow_up_finished", self)


func destroy():
	EVENTS.emit_signal("play_sound_effect", $UseSound)
	queue_free()


#### INPUTS ####


#### SIGNAL RESPONSES ####

func _on_tween_all_completed() -> void:
	if !is_collected():
		vawing_up = !vawing_up
		_start_waving(vawing_up)
