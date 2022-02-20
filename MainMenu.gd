extends Control

	
func _ready():
	$VBoxContainer/NewButton.grab_focus()



func _on_NewButton_pressed():
	get_tree().change_scene("res://world.tscn")
	
func _on_LOAD_pressed():
	pass 
	
func _on_OPTIONS_pressed():
	get_tree().change_scene("res://Options.tscn")
	
func _on_QUIT_pressed():
	get_tree().quit()
