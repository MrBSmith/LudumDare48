tool
extends Node2D
class_name InteractiveObj

onready var area = get_node("Area2D")
var player_in_area = false
export var hidden = false setget set_hidden, is_hidden

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

#### BUILT-IN ####

func _ready() -> void:
	var __ = area.connect("body_entered", self, "_on_body_entered")
	__ = area.connect("body_exited", self, "_on_body_exited")


#### VIRTUALS ####



#### LOGIC ####


#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_body_entered(body: Node) -> void:
	if body.is_class("Player"):
		player_in_area = true

	
func _on_body_exited(body: Node) -> void:
	if body.is_class("Player"):
		player_in_area = false
