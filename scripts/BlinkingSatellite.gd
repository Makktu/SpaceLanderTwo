extends Sprite

var speed = 2

func _ready():
	$AnimationPlayer.play("blink")
	speed = $"/root/Global".random_float_number(1.0, 4.0)
	
func _physics_process(delta):
	position.x += speed
#	var random_movement = $"/root/Global".random_float_number(1, 10)
#	if random_movement == 9:
#		position.y += speed
#	if random_movement <= 3:
#		position.y -= speed
# the above is a rough draft for more random movement code for this feature


func _on_VisibilityNotifier2D_screen_entered():
	$ExtinctionTimer.start()


func _on_ExtinctionTimer_timeout():
	queue_free()
