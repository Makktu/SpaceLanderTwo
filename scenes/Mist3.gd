extends Sprite


func _ready():
	start_moving()
	
func start_moving():
	for n in 10000:
		position.x += 1
		position.y -=1
		yield(get_tree().create_timer(0.5), "timeout")
		if n == 9999:
			start_moving()
