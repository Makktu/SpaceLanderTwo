extends Sprite

func _on_VisibilityNotifier2D_screen_entered():
	$AnimationPlayer.play("glow")

func _on_VisibilityNotifier2D_screen_exited():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("RESET")
