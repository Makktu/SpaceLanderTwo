extends KinematicBody2D

onready var shooting_star = preload("res://scenes/decor_only/ShootingStar.tscn")
onready var blinking_satellite = preload("res://scenes/decor_only/BlinkingSatellite.tscn")
onready var the_player = get_tree().get_nodes_in_group("player")[0]

var meteor_shower = false
var meteor_count = 1


func _ready() -> void:
	$ShootingStarTimer.start()
	$MeteorShowerTimer.start()
	$BlinkingSatelliteTimer.start()
	

#func _physics_process(delta):
#	$DecorAddOns.play()

func _on_EndLevel_body_entered(body):
	if body.name == "player":
		get_tree().change_scene("res://scenes/EndLevelScreen.tscn")
		

func spawn_the_shooting_star():
	if meteor_shower and meteor_count > 40:
		var stop_meteor_shower_chance = $"/root/Global".random_float_number(1, 10)
		if stop_meteor_shower_chance >= 9:
			meteor_shower = false
			meteor_count = 0
	var star_pos_x = the_player.position.x
	var star_pos_y = the_player.position.y
	var star = shooting_star.instance()
	get_parent().add_child(star)
	var random_spawn = $"/root/Global".random_float_number(-1100, 300)
	star.global_position.x = star_pos_x + 500
	star.global_position.y = star_pos_y + random_spawn
	if meteor_shower:
		meteor_count += 1
		$MultipleShootingStarsTimer.wait_time = $"/root/Global".random_float_number(0.15, 0.7)
		if meteor_count > 15:
			$MultipleShootingStarsTimer.wait_time = $"/root/Global".random_float_number(0.07, 0.3)
		$MultipleShootingStarsTimer.start()
	elif random_spawn < -100:
		$ShootingStarTimer.wait_time = $"/root/Global".random_float_number(2, 23)
		$ShootingStarTimer.start()
	else:
		$MultipleShootingStarsTimer.start()
	

func _on_ShootingStarTimer_timeout() -> void:
	var meteor_shower_chance = $"/root/Global".random_float_number(1, 1000)
	if meteor_shower_chance > 980 and !meteor_shower:
		meteor_shower = true
	spawn_the_shooting_star()
	
	
func _on_MultipleShootingStarsTimer_timeout():		
	spawn_the_shooting_star()


func _on_MeteorShowerTimer_timeout():
	meteor_shower = true
	$MeteorShowerTimer.wait_time = $"/root/Global".random_float_number(360, 600)
	$MeteorShowerTimer.start()
	spawn_the_shooting_star()


func _on_BlinkingSatelliteTimer_timeout():
	if $"/root/Global".random_float_number(1, 10) > 5:
		$BlinkingSatelliteTimer.start()
	else:
		var blinking_pos_x = the_player.position.x
		var blinking_pos_y = the_player.position.y
		var blink_sat = blinking_satellite.instance()
		get_parent().add_child(blink_sat)
		var random_spawn = $"/root/Global".random_float_number(-600, -300)
		blink_sat.global_position.x = blinking_pos_x - 500
		blink_sat.global_position.y = blinking_pos_y + random_spawn
		$BlinkingSatelliteTimer.start()
