extends Node2D

class_name Item

const CLASS_NAME = 'Item'

onready var area = get_node("Area2D")

var in_inventory = false
var player_in_area = false

#### ACCESSORS ####

func is_class(value: String): return value == CLASS_NAME or .is_class(value)
func get_class() -> String: return CLASS_NAME

#### BUILT-IN ####

func _ready() -> void:
	var __ = area.connect("body_entered", self, "_on_body_entered")
	__ = area.connect("body_exited", self, "_on_body_exited")


#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("action") && player_in_area:
		EVENTS.emit_signal("collect", self)

#### SIGNAL RESPONSES ####

func _on_body_entered(body: PhysicsBody2D) -> void:
	player_in_area = true

	
func _on_body_exited(body: PhysicsBody2D) -> void:
	player_in_area = false
