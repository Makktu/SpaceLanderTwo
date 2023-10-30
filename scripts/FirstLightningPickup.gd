extends Area2D


func _ready() -> void:
	$Sprite.visible = true

func _on_PickupSpot_body_entered(body):
	if body.name == 'player' and visible:
		$"/root/Global".energy_pickup()
		var spawn_time_now = $"/root/Global".random_float_number(100, 400)
		$SpawnTimer.wait_time = spawn_time_now
		$SpawnTimer.start()
		$AnimationPlayer.play("fade")
		$"/root/Global".lightning_weapon_equipped = true

func _on_SpawnTimer_timeout():
	# restore pickup
	$AnimationPlayer.play_backwards("fade")


func _on_AnimationPlayer_animation_finished(anim_name):
	visible = !visible


func _on_VisibilityNotifier2D_screen_entered() -> void:
	$Particles2D.emitting = true


func _on_VisibilityNotifier2D_screen_exited() -> void:
	$Particles2D.emitting = false


func _on_DelayTimer_timeout() -> void:
	$"/root/Global".pause_or_game_over("first_pickup")
	$"/root/Global".weapon_tutorial_done = true
