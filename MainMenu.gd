extends Control

	
func _ready():
	$VBoxContainer/NewButton.grab_focus()



func _on_NewButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/world.tscn")
	
func _on_LOAD_pressed():
	pass 
	
func _on_OPTIONS_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/Options.tscn")
	
func _on_QUIT_pressed():
	get_tree().quit()
