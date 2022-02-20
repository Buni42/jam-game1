extends KinematicBody2D


var speed = 300  

func _physics_process(delta: float) -> void:
	var velocity = Vector2(speed * delta, 0)
	position += velocity.rotated(rotation)
