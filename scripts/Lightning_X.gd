extends Node2D

	
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_up") and $"/root/Global".lightning_weapon_equipped and !$"/root/Global".lightning_weapon_active:
		start_weapon()
		
		
func start_weapon():
	$"/root/Global".lightning_weapon_active = true
	$"/root/Global".can_damage_player = false
	$LightningTimer.start()
	$The_Effect.visible = true
	$The_Effect/AnimatedSprite.playing = true
	$The_Effect/AnimatedSprite2.playing = true
	$The_Effect/AnimatedSprite3.playing = true
	$The_Effect/AnimatedSprite4.playing = true
	$The_Effect/explosion.visible = true
	$The_Effect/explosion.play("explode")
	get_tree().call_group("enemy", "_on_ExtinctionTimer_timeout")
	get_tree().call_group("barriers", "_lightning_active")
	for n in 1000:
		$The_Effect.rotation += 0.5




func _on_LightningTimer_timeout() -> void:
	$The_Effect.visible = false
	$The_Effect/AnimatedSprite.playing = false
	$The_Effect/AnimatedSprite2.playing = false
	$The_Effect/AnimatedSprite3.playing = false
	$The_Effect/AnimatedSprite4.playing = false
	$The_Effect/explosion.visible = false
	get_tree().call_group("enemy", "_on_ExtinctionTimer_timeout")
	$CooldownTimer.start()
	$"/root/Global".can_damage_player = true
	$"/root/Global".handle_pickups('weapon_fired')


func _on_CooldownTimer_timeout():
	# can fire weapon again
	$"/root/Global".lightning_weapon_active = false
