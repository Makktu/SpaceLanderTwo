extends Sprite

var movement_direction = 1

func _physics_process(_delta):
	position.x += movement_direction - 0.2
	if position.x >= 8000:
		movement_direction = -1
		position.x = 8000
	if position.x <= -8000:
		movement_direction = 1
		position.x = -8000
