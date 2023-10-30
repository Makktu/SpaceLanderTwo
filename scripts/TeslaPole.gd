extends Node2D

var tower_active = false


func _process(delta: float) -> void:
	if $"/root/Global".lightning_weapon_active and tower_active:
		$AnimationPlayer.stop()
		$RestartTimer.start()
		

func _on_RestartTimer_timeout() -> void:
	$AnimationPlayer.play("glow")


func _on_VisibilityEnabler2D_screen_entered() -> void:
	tower_active = true
	$AnimationPlayer.play("glow")


func _on_VisibilityEnabler2D_screen_exited() -> void:
	tower_active = false
	$AnimationPlayer.stop()
