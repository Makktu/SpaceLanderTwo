extends KinematicBody2D

var game_paused : bool = false
var input_vector : Vector2
var velocity : Vector2
export (int) var acceleration = 400
export (int) var max_speed = 500
export (int) var gravity = 10

var rotation_direction: int
export (float) var rotation_speed = 3.5

func _physics_process(delta):		
	input_vector.x = Input.get_action_strength("thrust")
	
	if Input.get_action_strength("thrust"):
		$AnimatedSprite.visible = true
		$AnimatedSprite.play("exhaust_full")
	else:
		$AnimatedSprite.visible = false
		$AnimatedSprite.play("exhaust_full")
		
	rotation_direction = 0
	
	if Input.is_action_pressed("rotate_left"):
		rotation_direction -= 1
	if Input.is_action_pressed("rotate_right"):
		rotation_direction += 1
	
	velocity += Vector2(input_vector.x * acceleration * delta, 0).rotated(rotation)
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	velocity.y = clamp(velocity.y, -max_speed, max_speed)
	
	velocity.y += gravity * delta
		
	rotation += rotation_direction * rotation_speed * delta
		
	velocity = move_and_slide(velocity)
	
	var collision_info = move_and_collide(velocity * delta)
	
	if collision_info:
		velocity.y -= 50
		velocity.x = -velocity.x
#		rotation += 2 * rotation_speed * delta
		print("DAMAGE!")
