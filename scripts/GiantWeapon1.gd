extends Node2D


func _ready():
	pass
#	$AnimationPlayer.play("rotate_me_slow")
#	$Timer.start()
	


func _on_Timer_timeout():
	$BarrierEmitter2.hide()
	$BarrierEmitter3.hide()
	$AnimationPlayer.play("rotate_me_fast")
	$AnimationPlayer.playback_speed = 4
	$Timer2.start()


func _on_Timer2_timeout():
	$AnimationPlayer.play("rotate_me_slow")
	show()
	$Timer.start()
