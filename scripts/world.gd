extends Node2D

onready var level = get_node(level_select)
var level_select = "level1"
var enemies_pos_array = []
export(Script) var GameSaveClass
var saved_vars = ["PlayerPos", "PlayerHealth", "PlayerAmmo", "Enemies"]

func _ready() -> void:
	Game.playerStartPos = $player.position
	Game.game_state = "playing"
	Globals.world = self
	if Game.load_game == true:
		loadGame()
	Game.load_game = false

func _input(event: InputEvent) -> void:
#	if event is InputEventKey:   save game automatically
#		if get_tree().quit():
#			saveGame()
	if event is InputEventKey and event.scancode == KEY_ESCAPE:
		saveGame()

##
## save and load Functions
##
func verifySave(game_save):
	for vars in saved_vars:
		if game_save.get(vars) == null:
			return false
	return true

func saveGame():
	var dir = Directory.new()
	var new_save = GameSaveClass.new()
	new_save.PlayerPos = $player.position
	new_save.PlayerHealth = Game.playerhealth
	if not dir.dir_exists("res://saves/"):
		dir.make_dir_recursive("res://saves/")

# warning-ignore:return_value_discarded
	ResourceSaver.save("res://saves/save_01.tres", new_save)
	print("game saved")

func loadGame():
	var dir = Directory.new()
	if not dir.file_exists("res://saves/save_01.tres"):
		return false
	var game_save = load("res://saves/save_01.tres")
	if not verifySave(game_save):
		return false
	
	$player.position = game_save.PlayerPos
	Game.playerhealth = game_save.PlayerHealth
	print("game loaded")
	return true
	pass
