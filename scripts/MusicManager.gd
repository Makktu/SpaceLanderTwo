extends Node2D

# A crude music player
# because there's no time to make a better one.
# When each track finishes it starts the next
# and finally loops back to the first.

func _ready():
	if $"/root/Global".music_on:
		start_music()
		
func start_music():
	var starting_track = 3
	starting_track = round($"/root/Global".random_float_number(0,8))
	if starting_track == 8:
		starting_track = 7
	if starting_track == 0:
		starting_track = 1

	if $"/root/Global".music_on:
		if starting_track == 1:
			$Track1.play()
		elif starting_track == 2:
			$Track2.play()
		elif starting_track == 3:
			$Track3.play()
		elif starting_track == 4:
			$Track4.play()
		elif starting_track == 5:
			$Track5.play()
		elif starting_track == 6:
			$Track6.play()
		elif starting_track == 7:
			$Track7.play()
		else:
			$Track3.play()

func stop_music():
	$Track1.stop()
	$Track2.stop()
	$Track3.stop()
	$Track4.stop()
	$Track5.stop()
	$Track6.stop()
	$Track7.stop()

func _on_Track1_finished():
	if $"/root/Global".music_on:
		$Track2.play()

func _on_Track2_finished():
	if $"/root/Global".music_on:
		$Track3.play()

func _on_Track3_finished():
	if $"/root/Global".music_on:
		$Track4.play()

func _on_Track4_finished():
	if $"/root/Global".music_on:
		$Track5.play()

func _on_Track5_finished():
	if $"/root/Global".music_on:
		$Track6.play()

func _on_Track6_finished():
	if $"/root/Global".music_on:
		$Track7.play()

func _on_Track7_finished():
	if $"/root/Global".music_on:
		$Track1.play()
