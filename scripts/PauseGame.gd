extends Node2D

func _physics_process(_delta):
	
	if Input.is_action_pressed("pause"):
		$"/root/Global".pause_or_game_over("pause")
	
	if Input.is_action_pressed("unpause"):
		$"/root/Global".pause_or_game_over("unpause")
