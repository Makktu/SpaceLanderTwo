extends KinematicBody2D


func _on_EndLevel_body_entered(body):
	if body.name == "player":
		print("LEVEL ENDED")
