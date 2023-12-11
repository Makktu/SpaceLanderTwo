extends Area2D

var shield_on = false
var lightning_on = false
var speedup = false
var shield_chance = 10


func _ready() -> void:
	deploy_pickup()
	
	
func deploy_pickup():
	speedup = false
	shield_on = false
	lightning_on = false
	
	var pickup_chance = $"/root/Global".random_float_number(1, 50)
	
	if pickup_chance < 20:
		speedup = true
	else:
		if $"/root/Global".player_hits >= 8:
			shield_chance = 50
		if $"/root/Global".random_float_number(1,100) < shield_chance:
			shield_on = true
		else:
			lightning_on = true
		
		if shield_chance != 10:
			shield_chance = 10
	
	show_pickup()
	
func show_pickup():
	if shield_on:
		$Shield.visible = true
	elif lightning_on:
		$Sprite.visible = true
	elif speedup:
		$Speedup.visible = true
	else:
		print("MAJOR BUG HERE")		
		
	
func _on_PickupSpot_body_entered(body):
	if body.name == 'player' and visible:
		var spawn_time_now = $"/root/Global".random_float_number(5, 10)
		$SpawnTimer.wait_time = spawn_time_now
		$SpawnTimer.start()
		$AnimationPlayer.play("fade")
		if shield_on:
			$"/root/Global".handle_pickups('shield')
			return
		if lightning_on and $"/root/Global".lightning_weapon_equipped:
			return
		elif lightning_on:
			$"/root/Global".handle_pickups('lightning')
			return
		if speedup:
			$"/root/Global".handle_pickups("speedup")


func _on_SpawnTimer_timeout():
	visible = true
	deploy_pickup()


func _on_AnimationPlayer_animation_finished(anim_name):
	lightning_on = false
	speedup = false
	shield_on = false
	visible = false
	$Sprite.visible = false
	$Shield.visible = false
	$Speedup.visible = false


func _on_VisibilityNotifier2D_screen_entered() -> void:
	$Particles2D.emitting = true
	if speedup:
		$Speedup.visible = true
		$Speedup.playing = true

func _on_VisibilityNotifier2D_screen_exited() -> void:
	$Particles2D.emitting = false
	$Speedup.playing = false
	$Speedup.visible = true


func _on_DelayTimer_timeout() -> void:
	$"/root/Global".pause_or_game_over("first_pickup")
