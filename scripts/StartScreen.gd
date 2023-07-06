extends CenterContainer

func _ready():
	$AnimationPlayer.play("fade_in")
	$ShowStart.start()


func _on_StartButton_pressed():
	get_tree().change_scene("res://World.tscn")


func _on_ShowStart_timeout():
	$"../CenterContainer/StartButtonAnimation".play("btn_fade_in")
