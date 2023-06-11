extends Sprite

var movement_direction = 1

func _physics_process(delta):
	position.y += movement_direction - 0.2
