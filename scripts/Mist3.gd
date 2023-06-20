extends Sprite

var movement_direction = 1

func _physics_process(_delta):
	position.x += movement_direction
	if position.x > 5000:
		movement_direction = -1
		position.x = 5000
	if position.x < -5000:
		movement_direction = 1
		position.x = -5000
	
