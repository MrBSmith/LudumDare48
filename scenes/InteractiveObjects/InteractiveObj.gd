tool
extends Node2D
class_name InteractiveObj

onready var area = get_node("Area2D")

var player_in_area = false

export var hidden = false setget set_hidden, is_hidden
export var spectral = false setget set_spectral, is_spectral
export var is_ready = false

#### ACCESSORS ####

func is_class(value: String): return value == "InteractiveObj" or .is_class(value)
func get_class() -> String: return "InteractiveObj"

func set_hidden(value: bool) -> void:
	if !is_ready:
		yield(self, "ready")
	hidden = value
	if !Engine.editor_hint: # in the game (not in editor)
		visible = !value
	else:
		if hidden:
			set_modulate(Color(1, 1, 1, 0.4))
		else:
			set_modulate(Color.white)

func is_hidden() -> bool:
	return hidden

func is_spectral() -> bool:
	return spectral
	
func set_spectral(value: bool) -> void:
	spectral = value
	$Light2D.set_enabled(spectral)
	
	if spectral:
		set_modulate(Color(1, 1, 1, 0.2))
	else:
		set_modulate(Color.white)

#### BUILT-IN ####

func _ready() -> void:
	var __ = area.connect("body_entered", self, "_on_body_entered")
	__ = area.connect("body_exited", self, "_on_body_exited")
	is_ready = true

#### VIRTUALS ####

func interact() -> void:
	pass


func destroy():
	EVENTS.emit_signal("scatter_object", self, 30.0)
	queue_free()

#### LOGIC ####



func is_interactable() -> bool:
	return is_hidden() == is_spectral()

#### INPUTS ####

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("action") && player_in_area:
		interact()

#### SIGNAL RESPONSES ####

func _on_body_entered(body: Node) -> void:
	if body.is_class("Player"):
		player_in_area = true
		if !spectral:
			EVENTS.emit_signal("approch_interactable", self)


func _on_body_exited(body: Node) -> void:
	if body.is_class("Player"):
		player_in_area = false
		if !spectral:
			EVENTS.emit_signal("recede_interactable", self)
