extends Node2D

#var plus = 1
#
#var line_from = Vector2(0,0)
#var line_to = Vector2(100, 100)
#var line_color = Color(255,255,255)
#
#func _ready():
#	_draw()
#
#func _draw():
#	draw_line(line_from, line_to, line_color, 9)
#	move_line()
#
#func move_line():
#	line_from = Vector2(plus, plus)
#	line_to = Vector2(plus + 1, plus + 1)
#	plus += 1
#	$Timer.start()	
#
#func _on_Timer_timeout():
#	print(plus)
#	_draw()




func _on_VisibilityNotifier2D_screen_entered():
	$AnimationPlayer.play("line_grow")
#	$AnimationPlayer.playback_speed = 0.2


func _on_VisibilityNotifier2D_screen_exited():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("RESET")


func _on_AnimationPlayer_animation_finished(anim_name):
	print(anim_name)
#	$AnimationPlayer.play("RESET")
	if anim_name == 'fade_out':
		$AnimationPlayer.play("line_grow")
	else:
		$AnimationPlayer.play("fade_out")
	
