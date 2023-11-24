extends Area2D

var shield_on = false
var lightning_on = false
var speedup = false
var shield_chance = 10

func _ready() -> void:
	deploy_pickup()
	
	
func deploy_pickup():
	if $"/root/Global".random_float_number(1,5) < 10:
		speedup = true
#		$Speedup.visible = true
#		$Speedup.playing = true
#		$Speedup.play("chevrons")
	else:
		if $"/root/Global".player_hits < 3:
			shield_chance = 50
		if $"/root/Global".random_float_number(1,100) < shield_chance:
			shield_on = true
		else:
			lightning_on = true
						
		if shield_on:
			$Shield.visible = true
		else:
			$Sprite.visible = true		
	
		
	
func _on_PickupSpot_body_entered(body):
	if body.name == 'player' and visible:
		var spawn_time_now = $"/root/Global".random_float_number(100, 400)
		$SpawnTimer.wait_time = spawn_time_now
		$SpawnTimer.start()
		$AnimationPlayer.play("fade")
		if shield_on:
			$"/root/Global".handle_pickups('shield')
		if lightning_on:
			$"/root/Global".handle_pickups('lightning')
		if speedup:
			$"/root/Global".handle_pickups("speedup")


func _on_SpawnTimer_timeout():
	# restore pickup
#	$AnimationPlayer.play_backwards("fade")
	deploy_pickup()


func _on_AnimationPlayer_animation_finished(anim_name):
	visible = !visible


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
