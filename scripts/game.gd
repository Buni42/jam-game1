extends Node

var playerPos
var playerDamage = 10
var load_game = false
var playerhealth = 100
var game_state = ""
var playerStartPos
var gui

var enemy_data = {
	"turret" :{
		'health' : 10,
		'damage' : 5,
		'rof' : 1
	}
}
