extends Node2D

var movement_direction = 0.5

var update_pos = 0

func _physics_process(_delta):
	position.x += movement_direction
	# may have to spawn these in and control them that way!
#	if position.x > -1000:
#		movement_direction = -0.5
#		position.x = -1000
#	if position.x < -4600:
#		movement_direction = 0.5
#		position.x = -4600
	update_pos += 1
	if update_pos > 100:
		print('MIST_HEAVY1:', position.x)
		update_pos = 0
	
