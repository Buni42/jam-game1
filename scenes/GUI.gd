extends CanvasLayer

func _ready() -> void:
	Game.gui = self

func _process(_delta: float) -> void:
	updatePlayerHealthBar(Game.playerhealth)

func updatePlayerHealthBar(health):
	$HUD/TextureProgress/Tween.interpolate_property($HUD/TextureProgress, 'value', $HUD/TextureProgress.value, health, .01, Tween.TRANS_LINEAR)
	$HUD/TextureProgress/Tween.start()
	if health >= 75:
		$HUD/TextureProgress.set_tint_progress('27b017')
	elif health <= 75 and health >= 30:
		$HUD/TextureProgress.set_tint_progress('bd5313')
	elif health <= 30 and health >= 0:
		$HUD/TextureProgress.set_tint_progress('a21919')
	else:
		pass
#		GameState.game_state = "levelover"
#		GameState.StateHandler()
