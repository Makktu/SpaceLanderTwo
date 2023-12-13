extends Area2D

var shield_on = false
var lightning_on = false
var speedup = false
var shield_chance = 10
var keep_running = false


func _ready() -> void:
	deploy_pickup()
	
	
func deploy_pickup():
	if !keep_running:
		return
	$Shield.visible = false
	$Sprite.visible = false
	$Speedup.visible = false
	if $"/root/Global".player_hits >= 8:
		shield_chance = 80
	else:
		shield_chance = 10
	
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
	
	show_pickup()
	
func show_pickup():
	if shield_on:
		$Shield.visible = true
	if lightning_on:
		$Sprite.visible = true
	if speedup:
		$Speedup.visible = true
		$Speedup.playing = true
	$ChangeTimer.start()
	
func _on_PickupSpot_body_entered(body):
	if body.name == 'player':
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


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()


func _on_VisibilityNotifier2D_screen_entered() -> void:
	keep_running = true
	$Particles2D.emitting = true
	if speedup:
		$Speedup.visible = true
		$Speedup.playing = true
	$ChangeTimer.start()

func _on_VisibilityNotifier2D_screen_exited() -> void:
	keep_running = false
	$Particles2D.emitting = false
	$Speedup.playing = false
	$Speedup.visible = true


func _on_ChangeTimer_timeout():
	speedup = false
	lightning_on = false
	shield_on = false
	$Shield.visible = false
	$Sprite.visible = false
	$Speedup.visible = false
	$Speedup.playing = false
	$SpawnTimer.start()


func _on_SpawnTimer_timeout():
	deploy_pickup()
