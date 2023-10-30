extends Area2D

func _on_Boss1ZoomOut_body_entered(body):
	$"/root/Global".camera_is_zooming = true
