extends Node2D

func _on_VisibilityNotifier2D_screen_entered() -> void:
	visible = true
	$AnimatedSprite.playing = true
	$AnimatedSprite2.playing = true
	print("Light pillar showing and playing")


func _on_VisibilityNotifier2D_screen_exited() -> void:
	$AnimatedSprite.playing = false
	$AnimatedSprite2.playing = false
	visible = false
	print("Light pillar NOT showing and NOT playing")
