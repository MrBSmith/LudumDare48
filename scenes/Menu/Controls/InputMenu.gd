extends Control
class_name InputMenu

#Get the ActionList node, which is type VBoxContainer. It will contains all the input information
onready var _action_list = get_node("CanvasLayer/Column/ScrollContainer/ActionList")


func _ready():
	var _err = $InputMapper.connect('profile_changed', self, 'rebuild')
	$CanvasLayer/Column/ProfilesMenu.initialize($InputMapper)


#This function will be executed when the signal emited from $InputMapper.gd [Line 55] will be emited.
func rebuild(input_profile, is_customizable = false):
	_action_list.clear()
	for input_action in input_profile.keys(): 
		var line = _action_list.add_input_line(input_action, \
			input_profile[input_action], is_customizable) 
		if is_customizable:
			var _err = line.connect('change_button_pressed', self, \
				'_on_InputLine_change_button_pressed', [input_action, line])




#### INPUTS ####


#If the player press the ui_cancel button (ref to the project settings, might me ESCAPE) it will queue free the menu and back to the game
func _input(event):
	if event.is_action_pressed('ui_cancel'):
		queue_free()
		get_tree().paused = false


#### SIGNAL RESPONSE ####


#This function will set the process input to false, so that the player can change the input.
func _on_InputLine_change_button_pressed(action_name, line):
	set_process_input(false)
	
	$CanvasLayer/KeySelectMenu.open()
	var key_scancode = yield($CanvasLayer/KeySelectMenu, "key_selected")
	$InputMapper.change_action_key(action_name, key_scancode)
	line.update_key(key_scancode)
	
	#Resume the process when the user pressed a key
	set_process_input(true)


#This function will queue free the Input Menu and back to the game
func _on_PlayButton_pressed():
	#For loop to get all the profile's coresponding keys
	for action_name in $InputMapper.get_selected_profile().keys(): #get the name, get the key
		$InputMapper.change_action_key(action_name, $InputMapper.get_selected_profile()[action_name]) #change the key
		
	queue_free()
	get_tree().paused = false
