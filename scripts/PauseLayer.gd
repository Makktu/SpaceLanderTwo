extends CanvasLayer

var game_paused = false

var framerate_on = true

var current_energy = 0

func _ready():
	if !$"/root/Global".music_on:
		$MusicToggle.text = "music_OFF"
		
		
func _on_PauseButton_pressed():
	$"/root/Global".pause_or_game_over('pause')
	game_paused = get_tree().paused
	if game_paused:
		$EnemiesToggle.visible = true
		$DamageToggle.visible = true
		$FrameRateToggle.visible = true
		$MusicToggle.visible = true
		$SfxToggle.visible = true
		$Message.visible = true
	else:
		$EnemiesToggle.visible = false
		$DamageToggle.visible = false
		$FrameRateToggle.visible = false
		$MusicToggle.visible = false
		$SfxToggle.visible = false
		$Message.visible = false


func _on_EnemiesToggle_pressed():
	if $"/root/Global".debug_enemies_on:
		$"/root/Global".debug_enemies_on = false
		$EnemiesToggle.text = "enemies_OFF"
	else:
		$"/root/Global".debug_enemies_on = true
		$EnemiesToggle.text = "enemies_ON"


func _on_DamageToggle_pressed():
	if $"/root/Global".debug_damage_on:
		$"/root/Global".debug_damage_on = false
		$DamageToggle.text = "damage_OFF"
	else:
		$"/root/Global".debug_damage_on = true
		$DamageToggle.text = "damage_ON"
		


func _on_MusicToggle_pressed():
	if !$"/root/Global".music_on:
		$"/root/Global".music_on = true
		$MusicToggle.text = "music_ON"
		$"/root/Global".start_the_music()
	else:
		$"/root/Global".music_on = false
		$MusicToggle.text = "music_OFF"
		$"/root/Global".stop_the_music()



func _on_FrameRateToggle_pressed() -> void:
	if framerate_on:
		$FrameRateToggle.text = "frame_rate_OFF"
		$Frame_rate.visible = false
		framerate_on = false
	else:
		$FrameRateToggle.text = "frame_rate_ON"
		$Frame_rate.visible = true
		framerate_on = true
	
	
func _physics_process(delta):
	if framerate_on:
		$Frame_rate.text = str(Engine.get_frames_per_second())


func _on_SfxToggle_pressed():
	if !$"/root/Global".sound_effects_on:
		$"/root/Global".sound_effects_on = true
		$SfxToggle.text = "Sfx_ON"
	else:
		$"/root/Global".sound_effects_on = false
		$SfxToggle.text = "Sfx_OFF"
		
