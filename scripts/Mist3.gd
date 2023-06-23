extends Sprite

var movement_direction = 1

func _physics_process(_delta):
	position.x += movement_direction
	if position.x > 24000:
		movement_direction = -1
		position.x = 23990
	if position.x < -24000:
		movement_direction = 1
		position.x = -23990
	
