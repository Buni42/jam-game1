extends KinematicBody2D

var turrettype = 'turret'#so basically the turret enemy is using this bullet
var type = 'bullet' # has type bullet

var speed = 300  

func _physics_process(delta: float) -> void:
	var velocity = Vector2(speed * delta, 0)
	position += velocity.rotated(rotation)
