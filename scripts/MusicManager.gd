extends Node2D

# A crude music player
# because there's no time to make a better one.
# When each track finishes it starts the next
# and finally loops back to the first.

func _ready():
	if $"/root/Global".music_on:
		start_music()
		
func start_music():
	if $"/root/Global".music_on:
		# Track 3 is the starting track
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
