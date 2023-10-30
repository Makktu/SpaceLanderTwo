extends Node2D

var movement_direction = 0.25

var update_pos = 0

func _physics_process(_delta):
	position.x += movement_direction
	# may have to spawn these in and control them that way!
	if position.x > 15790:
		movement_direction = -0.25
		position.x = 15790
	if position.x < -13280:
		movement_direction = 0.25
		position.x = -13290
	update_pos += 1
	if update_pos > 100:
		update_pos = 0
	
