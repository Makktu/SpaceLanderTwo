extends Sprite

var movement_direction = 1

func _physics_process(delta):
	position.x -= movement_direction
	if position.y <= 3600:
		movement_direction = -1
		position.y = 3601
	if position.y >= 16000:
		movement_direction = 1
		position.y = 15999
	
