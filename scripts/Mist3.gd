extends Sprite

var movement_direction = 1

func _physics_process(delta):
	position.x += movement_direction
	
