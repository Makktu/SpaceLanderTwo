extends Node2D

var movement_direction = 0.5

func _physics_process(_delta):
	position.x += movement_direction
	if position.x > -1000:
		movement_direction = -0.5
		position.x = -1000
	if position.x < -4600:
		movement_direction = 0.5
		position.x = -4600
	
