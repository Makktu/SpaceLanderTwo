extends Control


func _ready():
	$SpaceLander2_title.visible = true
	$StartButton.visible = true
	$AnimationPlayer.play("fade_in")
	$StartButtonAnimation.play("btn_fade_in")
