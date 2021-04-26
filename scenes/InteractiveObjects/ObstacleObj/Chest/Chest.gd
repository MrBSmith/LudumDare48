tool
extends ObstacleObj
class_name Chest

const CLASS_NAME = 'Chest'

export var tresure_name : String = "Bomb"

onready var tresure_path : String = "res://scenes/InteractiveObjects/Item/" + tresure_name + "/" + tresure_name + ".tscn"
onready var tresure_scene = load(tresure_path)

#### ACCESSORS ####

func is_class(value: String): return value == CLASS_NAME or .is_class(value)
func get_class() -> String: return CLASS_NAME


#### BUILT-IN ####

func _ready():
	var __ = EVENTS.connect("interaction_failed", self, "_on_interaction_failed")

#### VIRTUALS ####



#### LOGIC ####



#### INPUTS ####



#### SIGNAL RESPONSES ####

func _on_body_entered(body: Node) -> void:
	if body.is_class("Player"):
		player_in_area = true
		if $StatesMachine.get_state_name() == "Idle" && !spectral:
			EVENTS.emit_signal("approch_interactable", self)


func _on_body_exited(body: Node) -> void:
	if body.is_class("Player"):
		player_in_area = false
		if $StatesMachine.get_state_name() == "Idle" && !spectral:
			EVENTS.emit_signal("recede_interactable", self)

func _on_interaction_failed(obj: InteractiveObj):
	if obj == self:
		$StatesMachine.set_state("Locked")
