extends Node2D

export (bool) var music_on = true


func _ready():
	if music_on:
		$Track1.play()
		

func _on_Track1_finished():
	$Track2.play()
