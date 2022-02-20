extends Control

func _process(delta):
	$Fps.text = "FPS: " + str(Engine.get_frames_per_second())

func _ready():
	pass 

func _on_BackButton_pressed():
	get_tree().change_scene("res://MainMenu.tscn")


func _on_Full_pressed():
	OS.window_fullscreen = !OS.window_fullscreen



func _on_FPS_pressed():
	$Fps.visible = !$Fps.visible
	

func _on_Vsy_pressed():
	OS.vsync_enabled =	!OS.vsync_enabled
