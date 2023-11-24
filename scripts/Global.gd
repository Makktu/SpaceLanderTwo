extends Node2D

onready var player_energy = 1000000


var music_on = false

var sound_effects_on = false

var game_over = false

var taking_damage = false
var can_damage_player = true
var debug_enemies_on = true
var debug_damage_on = true
var debug_framerate_on = false

var energy_pickup = false

var camera_is_zooming = false
var camera_zoom_direction = "out"
var camera_zoom_target = 1

var lightning_weapon_equipped = true
var lightning_weapon_active = false

var player_shields_on = true
var player_speed_boost = false

var first_shield_collected = false
var first_lightning_collected = false

var tentacle_struck = false
var beam_struck = false

var game_level = 0

var player_hits = 0

# variable controlling when the player will be encircled by enemies
# (not built yet)
var enemy_surround = true
var global_amount_to_be_spawned = 30
var global_spawn_delay = 3
var basic_enemy_speed = 250
###################################################################



func _ready():
	game_on(false)

func pause_or_game_over(state):
	if state == "pause":
		get_tree().paused = !get_tree().paused
		
	if state == "unpause":
		if $TutorialLayer.visible:
			$TutorialLayer.visible = false
		get_tree().paused = false
		
	if state == "game_over":
		if !debug_damage_on:
			return
		game_over = true
		game_on(false)
		$GameOverLayer.visible = true
		get_tree().paused = true
		
	if state == "first_pickup":
		$TutorialLayer.visible = true
		$TutorialLayer/TutorialAnimationPlayer.play("glowtext")
		get_tree().paused = true
		

func restart_game():
	$GameOverLayer.visible = false
	game_over = false
	get_tree().paused = false
	lightning_weapon_equipped = true
	player_shields_on = true
	player_hits = 0
	lightning_weapon_active = false
	game_on(true)
	get_tree().change_scene("res://World.tscn")


func stop_the_music():
	$MusicManager.stop_music()


func start_the_music():
	$MusicManager.start_music()
	
	
func random_float_number(lower_value, upper_value):
	var random_generator = RandomNumberGenerator.new()
	random_generator.randomize()
	var random_value = random_generator.randf_range(lower_value, upper_value)
	return random_value
	
func camera_zoom(target):
	camera_zoom_target = target
	camera_is_zooming = true
	
#func energy_pickup():
#	$DisplayEnergy.show_lightning()
	
func lightning_weapon_used():
	$DisplayEnergy.hide_lightning()
	
func shield_used():
	$DisplayEnergy.hide_shield()
	player_shields_on = false
	
func handle_pickups(item):
	if item == 'speedup':
		player_speed_boost = true
		$DisplayEnergy.show_speed_boost()
		# add animation for this pickup
	
	if item == 'lightning':
		if lightning_weapon_equipped:
			# take no action if lightning already picked up
			# (doesn't stack)
			return
		else:
			$DisplayEnergy.show_lightning()
			$DisplayEnergy/AnimationPlayer.play("new_lightning")	
			lightning_weapon_equipped = true		
	if item == 'shield':
		if !player_shields_on:
			$DisplayEnergy.show_shield()
		player_hits = 0
		$DisplayEnergy/AnimationPlayer.play("RESET")
		$DisplayEnergy/AnimationPlayer.playback_speed = 1
		$DisplayEnergy/AnimationPlayer.play("picked_up_new")
			
	if item == 'weapon_fired':
		$DisplayEnergy.hide_lightning()
		lightning_weapon_equipped = false
	
func player_damaged(how_badly):
	player_hits += how_badly
	if player_hits >= 10:
		pause_or_game_over('game_over')
	else:
		$DisplayEnergy.shake_shield()
	if player_hits > 6:
		$DisplayEnergy/AnimationPlayer.play("low_shield")
	if player_hits > 8:
		$DisplayEnergy/AnimationPlayer.playback_speed *= 1.5
		$DisplayEnergy/AnimationPlayer.play("low_shield")
		
func game_on(state):
	if state:
		$DisplayEnergy.show_lightning()
		$DisplayEnergy.show_shield()
	else:
		$DisplayEnergy.hide_lightning()
		$DisplayEnergy.hide_shield()
		
		
func reset_global_values():
#	$ResetTimer.start()
	pass


func _on_ResetTimer_timeout():
	global_amount_to_be_spawned = 10
	global_spawn_delay = 10
	basic_enemy_speed = 150
