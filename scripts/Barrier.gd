extends Node2D

func _on_VisibilityNotifier2D_screen_entered():
	$starting_anim.play("starting_up")

func _on_VisibilityNotifier2D_screen_exited():
	$starting_anim.stop()
