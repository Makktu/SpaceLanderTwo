extends Control


func _ready():
	$"/root/Global".shield_used()
	$"/root/Global".lightning_weapon_used()


func _on_Button_pressed():
	get_tree().change_scene("res://scenes/StartScreen.tscn")
