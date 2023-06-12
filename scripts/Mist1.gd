extends Sprite

var movement_direction = 1

func _physics_process(_delta):
	position.x += movement_direction - 0.2
	
	if position.x >= 19000:
		movement_direction = -1
	if position.x <= 8890:
		movement_direction = 1
