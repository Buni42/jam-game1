extends StaticBody2D

export (PackedScene)var Bullet
var Detected = false
var ready = true
var bullet
var rof = 1
var playerpos


func _physics_process(_delta):
	if Detected:
		if ready:
			BulletSpawn()


func BulletSpawn():
	ready = false
	print (playerpos)
	bullet = Bullet.instance()
	bullet.rotation = Vector2(1, 0).angle_to((playerpos - position).normalized())
	$BulletContainer.add_child(bullet)
	$Timer.start(rof); yield($Timer, "timeout")
	ready = true
	
	
func _on_Area2D_body_entered(body):
	print(Game.playerPos)
	Detected = true
	playerpos = body.position

func _on_Area2D_body_exited(_body):
	Detected = false

