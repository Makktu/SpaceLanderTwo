extends Node2D

func spin_spark():
	$Anim_sparky.visible = true
	$Anim_sparky.playing = true	
	for n in 1000:
		rotation_degrees += 0.2
		
func end_spark():
	$Anim_sparky.visible = false
	$Anim_sparky.playing = false
	
