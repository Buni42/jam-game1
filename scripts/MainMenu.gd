extends Control

	
func _ready():
	$VBoxContainer/NewButton.grab_focus()



func _on_NewButton_pressed():
# warning-ignore:return_value_discarded
	restart()
	get_tree().change_scene("res://scenes/world.tscn")
	var dir = Directory.new()
	if Game.game_state == "death":
		if dir.dir_exists("res://saves/"):
			dir.remove("res://saves/save_01.tres")
	
	
func _on_LOAD_pressed():
	Game.load_game = true
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/world.tscn")
	
func _on_OPTIONS_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/Options.tscn")
	
func _on_QUIT_pressed():
	get_tree().quit()

func restart():
	Game.playerhealth = 100
