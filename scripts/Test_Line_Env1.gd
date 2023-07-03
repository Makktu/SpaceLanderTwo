extends KinematicBody2D

#var glow_direction = 0.01

func _ready():
	pass


func _on_EndLevel_body_entered(body):
	if body.name == "player":
		print("LEVEL ENDED")


#func _physics_process(delta):
#	$WorldEnvironment.gl
#	$WorldEnvironment.glow_intensity += glow_direction
#	if $WorldEnvironment.glow_intensity > 1.5:
#		glow_direction = -0.01
#	if $WorldEnvironment.glow_intensity <= 0.2:
#		glow_direction = 0.01
