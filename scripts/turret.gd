extends StaticBody2D

export (PackedScene)var Bullet
var Detected = false
var ready = true
var bullet
var rof = Game.enemy_data["turret"]['rof']
var playerpos
var type = 'turret'


func _physics_process(_delta):
	if ready:
		BulletSpawn()


func BulletSpawn():
	if Detected:
		print(playerpos)
		ready = false
		bullet = Bullet.instance()
		bullet.rotation = Vector2(1, 0).angle_to((playerpos - position).normalized())
		$BulletContainer.add_child(bullet)
		$Timer.start(rof); yield($Timer, "timeout")
		ready = true
	

func death():
	$AnimatedSprite2.call_deferred('visible', true)
	$AnimatedSprite2.play("death")
	$AnimatedSprite.call_deferred('visible', false)

func _on_Area2D_body_entered(body):
	Detected = true
	playerpos = body.position
	if body.type == "Playerbullet":
		print('hit')
		Game.enemy_data["turret"]['health'] -= Game.playerDamage
		if Game.enemy_data["turret"]['health'] >= 0:
			death()
		


func _on_Area2D_body_exited(_body):
	Detected = false

