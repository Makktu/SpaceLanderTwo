extends KinematicBody2D

var direction_of_travel_x = 1
var direction_of_travel_y = 1
var sentinel_moving_x = false
var sentinel_moving_y = false
var just_had_a_stop = false
var rotate_a_bit = false
var stopped_by_lightning = false
var stopped_by_lightning_time = 20
var stopped_by_bullets_time = 10
var hit_by_bullets = 0

onready var bulletBurst = preload("res://scenes/BulletBurst.tscn")


func _physics_process(delta: float) -> void:
	if $"/root/Global".lightning_weapon_active and !stopped_by_lightning:
		$TeslaBeam.can_fire_beam = false
		$TeslaBeam.visible = false
		stopped_by_lightning = true
		$StruckByLightningTimer.wait_time = stopped_by_lightning_time
		$Anim_sparky.visible = true
		$Anim_sparky.playing = true
		$StruckByLightningTimer.start()
	else:
		if !sentinel_moving_x and !sentinel_moving_y:
			rotation += 0.0015
		if rotate_a_bit:
			rotation += 0.01
		if sentinel_moving_x:
			position.x += direction_of_travel_x
		if sentinel_moving_y:
			position.y += direction_of_travel_y
		if sentinel_moving_x or sentinel_moving_y:
			if not just_had_a_stop:
				on_patrol()
		if position.y < 7 or position.y > 977:
			direction_of_travel_y = -direction_of_travel_y
		if position.x < -1104 or position.x > 11860:
			direction_of_travel_x = -direction_of_travel_x
	
	
func on_patrol():
	var factor_one = $"/root/Global".random_float_number(1,20)
	if factor_one > 19:
		if $"/root/Global".random_float_number(1, 100) > 90:
			sentinel_moving_x = false
			sentinel_moving_y = false
			$WaitTimer.wait_time = $"/root/Global".random_float_number(1, factor_one) + 5
			$WaitTimer.start()
	if factor_one < 4:
		if $"/root/Global".random_float_number(1,100) < 51:
			direction_of_travel_x = -direction_of_travel_x
		else:
			direction_of_travel_y = -direction_of_travel_y
	if factor_one > 8 and factor_one < 12 and !rotate_a_bit:
		rotate_a_bit = true
		$RotationTimer.start()
		


func _on_WaitTimer_timeout() -> void:	
	if $"/root/Global".random_float_number(1, 10) > 5:
		sentinel_moving_x = true
	else:
		sentinel_moving_y = true
	for n in 3000:
		rotation_degrees += 0.0005
	just_had_a_stop = true
	$HadStopTimer.wait_time = $"/root/Global".random_float_number(10, 30)
	$HadStopTimer.start()
	on_patrol()


func _on_Enemy2_Sentinel_body_entered(body: Node) -> void:
	if body.name == 'player':
		$"/root/Global".taking_damage = true
	else:
		direction_of_travel_x = -direction_of_travel_x
		direction_of_travel_y = -direction_of_travel_y
		
		
func _on_VisibilityNotifier2D_screen_entered() -> void:
	sentinel_moving_x = true
	$TeslaBeam.can_fire_beam = true
	$TeslaBeam.visible = true
	print("SENTINEL STARTED")


func _on_VisibilityNotifier2D_screen_exited() -> void:
	sentinel_moving_x = false
	sentinel_moving_y = false
	$TeslaBeam.can_fire_beam = false
	$TeslaBeam.visible = false
	print("SENTINEL STOPPED")


func _on_HadStopTimer_timeout() -> void:
	just_had_a_stop = false


func _on_StruckByLightningTimer_timeout() -> void:
	stopped_by_lightning = false
	$TeslaBeam.visible = true
	$Anim_sparky.playing = false
	$Anim_sparky.visible = false
	$TeslaBeam.can_fire_beam = true


func _on_RotationTimer_timeout() -> void:
	rotate_a_bit = false



func _on_Enemy2_Sentinel_area_entered(area):
	if area.name == "BulletArea":
		print('HITTTT')
		var bulletImpact = bulletBurst.instance()
		bulletImpact.scale.x += 10
		bulletImpact.scale.y += 10
		add_child(bulletImpact)
		hit_by_bullets += 1
		print(hit_by_bullets)
		if hit_by_bullets == 10:
			queue_free()


func _on_BulletsDetector_area_entered(area):
	if area.name == "BulletArea":
		print('HITTTT')
		hit_by_bullets += 1
		print(hit_by_bullets)
		if hit_by_bullets == 10:
			$TeslaBeam.can_fire_beam = false
			$TeslaBeam.visible = false
			stopped_by_lightning = true
			$StruckByLightningTimer.wait_time = stopped_by_bullets_time
			$Anim_sparky.visible = true
			$Anim_sparky.playing = true
			$StruckByLightningTimer.start()
