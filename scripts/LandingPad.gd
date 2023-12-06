extends StaticBody2D


func _ready():
	pass


func _on_Area2D_body_entered(body):
	if body.name == 'player':
		print("LANDED")


func _on_VisibilityNotifier2D_screen_entered():
	$AnimationPlayer.play("throbbing")


func _on_VisibilityNotifier2D_screen_exited():
	$AnimationPlayer.stop()
