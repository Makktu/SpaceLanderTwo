extends Sprite

var movement_direction = 1

func _physics_process(delta):
	position.x += movement_direction
	if position.x > 10000:
		position.x = -11000
	
