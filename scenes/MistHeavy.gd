extends Node2D

var movement_direction = 0.5

func _physics_process(_delta):
	position.x += movement_direction
	if position.x > 11000:
		movement_direction = -0.5
		position.x = 11000
	if position.x < -11000:
		movement_direction = 0.5
		position.x = -10990
	
