extends Button


func _ready() -> void:
	pass


func _on_Button_pressed() -> void:
	$"../TutorialAnimationPlayer".stop()
	$"/root/Global".pause_or_game_over("unpause")
