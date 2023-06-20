extends KinematicBody2D

onready var Swipe = $Camera2D/TouchScreenControls
var swipe_up = false
var swipe_down = false
var swipe_left = false
var swipe_right = false
var swipe_down_released = false
var swipe_up_released = false
var swipe_left_released = false
var swipe_right_released = false

var game_paused : bool = false
var input_vector : Vector2
var velocity : Vector2

var rotation_direction: int

#export (int) var acceleration = 100 or 25?
#export (int) var max_speed = 200 or 40?
#export (int) var gravity = 5 or 3?
#export (float) var rotation_speed = 2.5

export (int) var acceleration = 30
export (int) var max_speed = 50
export (int) var gravity = 7
export (float) var rotation_speed = 2.5

var shields = 100


func _physics_process(delta):
	if $"/root/Global".in_gravity_trap:
		gravity = $"/root/Global".changed_gravity
	else:
		gravity = $"/root/Global".world_gravity
	
	input_vector.x = Input.get_action_strength("thrust")
	
	if swipe_up:
		input_vector.x = 1
	
	if Input.get_action_strength("thrust") || swipe_up:
		$AnimatedSprite.visible = true
		$AnimatedSprite.play("exhaust_full")
	else:
		$AnimatedSprite.visible = false
		$AnimatedSprite.play("exhaust_full")
		
	rotation_direction = 0
	
	if Input.is_action_pressed("rotate_left") || swipe_right:
		rotation_direction -= 1
	if Input.is_action_pressed("rotate_right") || swipe_left:
		rotation_direction += 1
		
	if swipe_left_released || swipe_right_released:
		rotation_direction = 0
		swipe_left_released = false
		swipe_right_released = false
	
	velocity += Vector2(input_vector.x * acceleration * delta, 0).rotated(rotation)
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	velocity.y = clamp(velocity.y, -max_speed, max_speed)
	
	velocity.y += gravity * delta
		
	rotation += rotation_direction * rotation_speed * delta
		
	velocity = move_and_slide(velocity)
	
	var collision_info = move_and_collide(velocity * delta)
	
	if collision_info:
		velocity.y = -velocity.y * 1.35
		velocity.x = -velocity.x * 1.35
		shields -= 10
		print("DAMAGE", " >> SHIELDS: ", shields)
		$Animated_Forcefield.visible = true
		$Animated_Forcefield2.visible = true
		$Animated_Forcefield.play("forcefield")
		$Animated_Forcefield2.play("forcefield")
		$Forcefield_Timer.start()
		if shields <= 0:
			shields = 100
			$"/root/Global".pause_or_game_over("game_over")
		
func _input(event):
	if event is InputEventScreenDrag:
		if Swipe.get_swipe_direction(event.relative, 5) == Vector2.UP:
			swipe_down = true
		if Swipe.get_swipe_direction(event.relative, 5) == Vector2.DOWN:
			swipe_up = true
		if Swipe.get_swipe_direction(event.relative, 5) == Vector2.LEFT:
			swipe_right = true
		if Swipe.get_swipe_direction(event.relative, 5) == Vector2.RIGHT:
			swipe_left = true
			
	if Swipe.on_area == false && swipe_down == true:
		swipe_down_released = true
		swipe_down = false
	if Swipe.on_area == false && swipe_up == true:
		swipe_up_released = true
		swipe_up = false
	if Swipe.on_area == false && swipe_left == true:
		swipe_left_released = true
		swipe_left = false
	if Swipe.on_area == false && swipe_right == true:
		swipe_right_released = true
		swipe_right = false


func _on_Forcefield_Timer_timeout():
	$Animated_Forcefield.stop()
	$Animated_Forcefield.visible = false
	$Animated_Forcefield2.stop()
	$Animated_Forcefield2.visible = false
