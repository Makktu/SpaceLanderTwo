extends Node2D


func _on_VisibilityNotifier2D_screen_entered():
	$AnimationPlayer.play("modulate_tower")


func _on_VisibilityNotifier2D_screen_exited():
	$AnimationPlayer.stop()

