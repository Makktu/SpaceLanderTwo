extends KinematicBody2D

onready var Swipe = $Camera2D/TouchScreenControls

const bullet = preload("res://scenes/Bullet.tscn")

var spin_out = false

var player_is_shooting = false

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

# PLAYER CONTROLLER VARIABLES
# PREVIOUS TEST VALUES COMMENTED TO SIDE
var acceleration = 30 #30
var max_speed = 70
var gravity = 0 #0 FOR FULL WEIGHTLESSNESS
var rotation_speed = 3 #6


func _physics_process(delta):
	
	if $"/root/Global".player_speed_boost:
		$"/root/Global".player_speed_boost = false
		acceleration += 15
		max_speed += 25
		rotation_speed += 2
		$BoostTimer.wait_time = 15
		$BoostTimer.start()
	
	if $"/root/Global".enemy_surround:
		surround_with_enemies()
	
	# BOSS TENTACLE STRIKE LOGIC
	if $"/root/Global".tentacle_struck:
		if $AnimatedSprite.visible:
			$AnimatedSprite.visible = false
			velocity.y = velocity.y / 2
			velocity.x = velocity.x / 2
		rotation_direction = -1
		rotation += rotation_direction * 3 * delta
		if $SpinOutTimer.is_stopped():
			$SpinSpark.visible = true
			$SpinSpark.spin_spark()
			$SpinOutTimer.start()
		
	if $"/root/Global".camera_is_zooming:
		$"/root/Global".camera_is_zooming = false
		camera_controller($"/root/Global".camera_zoom_direction)

	input_vector.x = Input.get_action_strength("thrust")
	
	if swipe_up:
		input_vector.x = 1
	
	if Input.get_action_strength("thrust") || swipe_up:
		$AnimatedSprite.visible = true
		$AnimatedSprite.play("exhaust_full")
#		if !$ThrusterSfx.playing:
#			$ThrusterSfx.play()
	else:
		$AnimatedSprite.visible = false
		$AnimatedSprite.play("exhaust_full")
#		$ThrusterSfx.stop()
		
	rotation_direction = 0
	
	if Input.is_action_pressed("fire_bullets") and !player_is_shooting:
		player_is_shooting = true
		shoot_bullets()
		
	if Input.is_action_just_released("fire_bullets"):
		player_is_shooting = false
	
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
	
#	velocity.y += gravity * delta
		
	rotation += rotation_direction * rotation_speed * delta
		
	velocity = move_and_slide(velocity)
	
	var collision_info = move_and_collide(velocity * delta)
	
	if collision_info or $"/root/Global".taking_damage:	
		if collision_info:
			var collided_with = collision_info.collider.name.left(5)
#			print(">>>", collided_with)
			if collided_with == "Bulle" or collided_with == "@bull":
				return
		if !$"/root/Global".debug_damage_on or player_is_shooting:
			return
		$"/root/Global".player_damaged(0.1)
		velocity.y = -velocity.y * 1.35
		velocity.x = -velocity.x * 1.35
		if $"/root/Global".taking_damage:
			$"/root/Global".taking_damage = false
		$Animated_Forcefield.visible = true
		$Animated_Forcefield2.visible = true
		$Animated_Forcefield.play("forcefield")
		$Animated_Forcefield2.play("forcefield")
		$Forcefield_Timer.start()
		$SlightDamageAnimation.play("slight")
		yield($SlightDamageAnimation, "animation_finished")
		$SlightDamageAnimation.play("RESET")
#		if !$"/root/Global".player_shields_on:
#			$"/root/Global".pause_or_game_over("game_over")
			
		
func _input(event):
	if event is InputEventScreenDrag:
		if Swipe.get_swipe_direction(event.relative, 5) == Vector2.UP:
			swipe_down = true
			if $"/root/Global".lightning_weapon_equipped:
				$"/root/Global".lightning_weapon_active = true
				$Lightning_X.start_weapon()
			else:
				player_is_shooting = true
				shoot_bullets()
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



func _on_RechargeTimer_timeout():
	$RechargingAnimatedSprite.visible = false
	$RechargingAnimatedSprite.stop()
	$Animated_Forcefield.visible = false
	$Animated_Forcefield2.visible = false
	$Animated_Forcefield.stop()
	$Animated_Forcefield2.stop()
	
func camera_controller(direction):
	var zoom_amount
	if direction == "out":
		zoom_amount = 0.002
	else:
		zoom_amount = -0.002
	var current_zoom_x = $Camera2D.zoom.x
	var current_zoom_y = $Camera2D.zoom.y
	for n in 500:
		current_zoom_x += zoom_amount
		current_zoom_y += zoom_amount
		$Camera2D.zoom = Vector2(current_zoom_x, current_zoom_y)
		yield(get_tree().create_timer(0.3), "timeout")
		if direction == "out" and current_zoom_x >= $"/root/Global".camera_zoom_target + 4:
			break
		if direction == "in" and current_zoom_x <= $"/root/Global".camera_zoom_target:
			break
	if direction == "out":
		$CameraZoomBackTimer.start()
	else:
		# return camera zoom setting to 'out' if it's not
		# want the default zoom direction to be 'out'
		$"/root/Global".camera_zoom_direction = "out"
	


func _on_SpinOutTimer_timeout():
	$"/root/Global".tentacle_struck = false
	spin_out = false
	$SpinSpark.end_spark()


func _on_CameraZoomBackTimer_timeout():
	$"/root/Global".camera_zoom_direction = "in"
	$"/root/Global".camera_is_zooming = true
	
	
func shoot_bullets():
	var bullet_instance = bullet.instance()
	bullet_instance.global_position = $firing_point.global_position
	bullet_instance.global_rotation_degrees = rotation_degrees - 90
	# the adding of the bullet to the scene
	get_parent().add_child(bullet_instance)
#	$ShootingTimer.start()
	
	
func _on_ShootingTimer_timeout() -> void:
	player_is_shooting = false


func _on_TouchScreenControls_double_tap() -> void:
	shoot_bullets()
	
func surround_with_enemies():
	pass
	# first, destroy all enemies currently in game (performance reasons)


func _on_BoostTimer_timeout() -> void:
	acceleration = 30
	max_speed = 70
	rotation_speed = 3
