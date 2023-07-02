extends Node2D

var movement_direction = 0.5

var update_pos = 0

func _physics_process(_delta):
	position.x += movement_direction
	# may have to spawn these in and control them that way!
	if position.x > 15790:
		movement_direction = -0.5
		position.x = 15790
	if position.x < -14940:
		movement_direction = 0.5
		position.x = -14935
	update_pos += 1
	if update_pos > 100:
		print('MIST_HEAVY1:', position.x)
		update_pos = 0
	
