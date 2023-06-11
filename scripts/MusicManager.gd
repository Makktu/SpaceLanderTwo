extends Node2D

export (bool) var music_on = true


func _ready():
	if music_on:
		$Track3.play()
		

func _on_Track1_finished():
	$Track2.play()
	

func _on_Track2_finished():
	$Track3.play()


func _on_Track3_finished():
	$Track1.play()


