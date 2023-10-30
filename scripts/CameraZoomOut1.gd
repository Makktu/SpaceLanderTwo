extends Area2D


func _on_CameraZoomOut1_body_exited(body):
	if body.name == 'player':
		print('should be running')
		$"/root/Global".camera_zoom(3)
