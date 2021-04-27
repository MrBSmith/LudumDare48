extends Node
class_name InputMapper

signal profile_changed(new_profile, is_customizable)

const CUSTOM_PROFILE : int = 2

var current_profile_id = 0

var profiles = {
	0: 'profile_azerty',
	1: 'profile_qwerty',
	2: 'profile_custom',
}

var profile_azerty = {
	'left': KEY_Q,
	'right': KEY_D,
	'jump': KEY_Z,
	'action': KEY_ENTER
}

var profile_qwerty = {
	'left': KEY_W,
	'right': KEY_D,
	'jump': KEY_A,
	'action': KEY_ENTER
}

var profile_custom = {
	'left': InputMap.get_action_list("left")[0].scancode,
	'right': InputMap.get_action_list("right")[0].scancode,
	'jump': InputMap.get_action_list("jump")[0].scancode,
	'action': InputMap.get_action_list("action")[0].scancode
}


func _ready() -> void:
	yield(owner, "ready")

	emit_signal("profile_changed", profile_azerty, false)


#Get the selected profile id to change it. Ref to profile var for more information
func change_profile(id):
	current_profile_id = id
	var profile = profiles[id]
	var is_customizable = true if id == 2 else false
	
	emit_signal('profile_changed', get(profile), is_customizable)

	return profile


# This function will remove the current action from the settings and add a new key as an event
func change_action_key(action_name, key_scancode):
	erase_action_events(action_name)

	var new_event = InputEventKey.new()
	new_event.set_scancode(key_scancode)
	new_event.set_scancode(key_scancode)
	InputMap.action_add_event(action_name, new_event)
	get_selected_profile()[action_name] = key_scancode


# This function will remove the selected action from the settings (InputMap)
func erase_action_events(action_name):
	var input_events = InputMap.get_action_list(action_name)
	for event in input_events:
		InputMap.action_erase_event(action_name, event)

func get_selected_profile():
	return get(profiles[current_profile_id])

func _on_ProfilesMenu_item_selected(ID):
	change_profile(ID)
