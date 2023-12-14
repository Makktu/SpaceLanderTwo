extends StaticBody2D


func _ready():
	pass


func _on_Area2D_body_entered(body):
	if body.name == 'player':
		$LandingTimer.start()



func _on_VisibilityNotifier2D_screen_entered():
	$AnimationPlayer.play("throbbing")


func _on_VisibilityNotifier2D_screen_exited():
	$AnimationPlayer.stop()


func _on_LandingTimer_timeout():
	get_tree().change_scene("res://scenes/EndLevelScreen.tscn")
