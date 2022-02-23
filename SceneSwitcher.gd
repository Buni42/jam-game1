extends Node

func _process(_delta):
	if Game.game_state == "death":
		get_node("main menu").queue_free()
