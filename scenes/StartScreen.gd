extends CenterContainer

func _ready():
#	$SpaceLander2_title.visible = true
#	$StartButton.visible = true
	$AnimationPlayer.play("fade_in")
	$"../CenterContainer/StartButtonAnimation".play("btn_fade_in")

func _on_StartButton_pressed():
	print("START PRESSED")
