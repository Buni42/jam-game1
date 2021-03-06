extends KinematicBody2D

export var max_speed_default: = Vector2(120.0, 550.0) 	#speed clamp X & Y
export var max_sprintspeed_default: = Vector2(300.0, 550.0) 	#speed clamp X & Y
export var acceleration_default: = Vector2(240, 1000.0)	#Acceleration & gravity
export var jump_impulse: = 550.0						#Jump force
export var friction_default: = 0.15						#Slipery st


const FLOOR_NORMAL: = Vector2.UP

var acceleration: = acceleration_default
var max_speed: = max_speed_default
var max_sprintspeed: = max_sprintspeed_default
var velocity: = Vector2.ZERO
var friction: = friction_default
var direction: = Vector2.DOWN


func _physics_process(delta):
	direction = get_move_direction()
	velocity = calculate_velocity(delta)
	
	if Game.playerhealth <= 0:
		death()
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_impulse
		$AnimationTree.set("parameters/OneShot_jump/active", true)
		if direction.x == -1:
			$AnimatedSprite.flip_h = true
			$CollisionPolygon2D.scale.x = -1
			$CollisionPolygon2D.position.x = -5
		else:
			$AnimatedSprite.flip_h = false
			$CollisionPolygon2D.scale.x = 1
			$CollisionPolygon2D.position.x = -1.18
		
	velocity = move_and_slide(velocity, FLOOR_NORMAL, false, 4, PI/4, false)

func calculate_velocity(delta: float) -> Vector2:
	var new_velocity: = velocity #Use temporary variable in case we want to manipulate the value later
	#HORIZONTAL
	if direction.x != 0   :
		$AnimationTree.set("parameters/OneShot_idle/active", false)
		$AnimationTree.set("parameters/walk_run/blend_amount", 0)
		new_velocity.x += direction.x * acceleration.x * delta
		new_velocity.x = clamp(new_velocity.x, -max_speed.x, max_speed.x) 
		print(new_velocity.x)
#		print(direction.x)
		if direction.x == -1:
			$AnimatedSprite.flip_h = true
			$CollisionPolygon2D.scale.x = -1
			$CollisionPolygon2D.position.x = -5
		else:
			$AnimatedSprite.flip_h = false
			$CollisionPolygon2D.scale.x = 1
			$CollisionPolygon2D.position.x = -1.18
		
		if Input.is_action_pressed("sprint"):
			$AnimationTree.set("parameters/OneShot_idle/active", false)
			$AnimationTree.set("parameters/walk_run/blend_amount", 1)
			new_velocity.x += direction.x * (acceleration.x*100)  * delta
			new_velocity.x = clamp(new_velocity.x, -max_sprintspeed.x, max_sprintspeed.x)
			print(new_velocity.x)

	else: #deaccelerate X
#		$AnimationTree.set("parameters/walk_run/blend_amount", 0)
		$AnimationTree.set("parameters/OneShot_idle/active", true)
		new_velocity.x = approach(new_velocity.x, 0, abs(new_velocity.x*friction))
		

	
	#VERTICAL
	new_velocity.y += acceleration.y * delta
	new_velocity.y = clamp(new_velocity.y, -max_speed.y, max_speed.y)
	return new_velocity

static func get_move_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		1.0
	)

static func approach(start: float, end: float, amount: float):
	if (start < end):
		return min(start + amount, end)
	else:
		return max(start - amount, end)



func _on_hitbox_body_entered(body):
	Game.playerhealth -= body.damage
	Globals.camera.shake(2500, 0.1 ,15000)
	body.queue_free()
	print(Game.playerhealth)

func death():
	print('ded')
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/MainMenu.tscn")
	Game.game_state = "death"
