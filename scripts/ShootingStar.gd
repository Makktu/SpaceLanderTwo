extends KinematicBody2D

func _ready() -> void:
	$AnimatedSprite.play("tail")
	rotation_degrees = 225
	var random_scale = get_random_scale_value()
	scale.x = random_scale
	scale.y = random_scale
	

func _physics_process(delta: float) -> void:
	position.y += 25
	position.x -= 25
	
	
func get_random_scale_value():
	var random_generator = RandomNumberGenerator.new()
	random_generator.randomize()
	var random_value = random_generator.randf_range(0.005,0.25)
	return random_value


func _on_Timer_timeout():
	queue_free()
