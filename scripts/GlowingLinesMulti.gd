extends Node2D

#
#func _on_VisibilityNotifier2D_viewport_entered(viewport):
#	print("GLOWING LINES NOW PLAYING")
#	$AnimationPlayer.play("glowy")
#
#
#func _on_VisibilityNotifier2D_viewport_exited(viewport):
#	$AnimationPlayer.stop()
#	$AnimationPlayer.play("RESET")
#	print("GLOWING LINES NOW STOPPED")


func _on_GlowingLinesMulti_body_entered(body):
	if body.name == 'player':
		print("GLOWING LINES NOW PLAYING")
		$AnimationPlayer.play("glowy")

func _on_GlowingLinesMulti_body_exited(body):
	if body.name == 'player':
		$AnimationPlayer.stop()
		$AnimationPlayer.play("RESET")
		print("GLOWING LINES NOW STOPPED")
