extends Node2D

func _ready():
	if $"/root/Global".music_on:
		start_music()


func _on_Track1_finished():
	if $"/root/Global".music_on:
		$Track2.play()


func _on_Track2_finished():
	if $"/root/Global".music_on:
		$Track1.play()


func _on_Track3_finished():
	if $"/root/Global".music_on:
		$Track1.play()


func start_music():
	if $"/root/Global".music_on:
		$Track1.play()


func stop_music():
	$Track1.stop()
	$Track2.stop()
	$Track3.stop()
