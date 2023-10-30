extends CenterContainer

func _ready():
	$AnimationPlayer.play("fade_in")
	$ShowStart.start()
	$"../AnimationPlayer".play("fade_down")


func _on_StartButton_pressed():
	$"/root/Global".restart_game()


func _on_ShowStart_timeout():
	$"../CenterContainer/StartButtonAnimation".play("btn_fade_in")
