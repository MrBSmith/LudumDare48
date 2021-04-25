tool
extends Node2D
class_name InteractiveObj

onready var area = get_node("Area2D")

var player_in_area = false

export var hidden = false setget set_hidden, is_hidden
export var spectral = false setget set_spectral, is_spectral

#### ACCESSORS ####

func is_class(value: String): return value == "InteractiveObj" or .is_class(value)
func get_class() -> String: return "InteractiveObj"

func set_hidden(value: bool) -> void:
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
		set_modulate(Color(1, 1, 1, 0.6))
	else:
		set_modulate(Color.white)

#### BUILT-IN ####

func _ready() -> void:
	var __ = area.connect("body_entered", self, "_on_body_entered")
	__ = area.connect("body_exited", self, "_on_body_exited")


#### VIRTUALS ####

func interact() -> void:
	pass

func destroy() -> void:
	call_deferred("queue_free")

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
		EVENTS.emit_signal("approch_interactable", self)


func _on_body_exited(body: Node) -> void:
	if body.is_class("Player"):
		player_in_area = false
		EVENTS.emit_signal("recede_interactable", self)


