extends Area2D


func _on_VisibilityNotifier2D_screen_entered():
	$AnimationPlayer.play("glowy")
	monitoring = true


func _on_VisibilityNotifier2D_screen_exited():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("RESET")
	monitoring = false


func _on_BarrierEmitter_body_entered(body):
	if body.name == 'player':
		$"/root/Global".taking_damage = true
