extends Node2D


func _ready():
	start_firing()
	

func start_firing():
	$starting_anim.play("starting_up")


#func _on_FireTimer_timeout():
#	$starting_anim.visible = true
#
#	$DurationTimer.start()
#
#
#
#func _on_DurationTimer_timeout():
#	$starting_anim.stop()
#	$starting_anim.visible = false
#	$FireTimer.start()
