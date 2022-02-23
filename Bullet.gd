extends KinematicBody2D

var damage = Game.enemy_data["turret"]['damage']
var speed = 300  

func _physics_process(delta: float) -> void:
	var velocity = Vector2(speed * delta, 0)
	position += velocity.rotated(rotation)
