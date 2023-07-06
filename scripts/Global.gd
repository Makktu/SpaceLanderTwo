extends Node2D

var world_gravity : int = 5
var changed_gravity : int = 0

var collision_with_ground : bool = false
var in_gravity_trap : bool = false

var world_color_changed : bool = false
var world_color_now = ""

var music_on = true

var game_over = false

var taking_damage = false

var debug_enemies_on = true
var debug_damage_on = true
var debug_framerate_on = false

func pause_or_game_over(state):
	if state == "pause":
		get_tree().paused = !get_tree().paused
		
	if state == "unpause":
		get_tree().paused = false
		
	if state == "game_over":
		game_over = true
		$GameOverLayer.visible = true
		get_tree().paused = true
		

func restart_game():
	$GameOverLayer.visible = false
	game_over = false
	get_tree().paused = false
	get_tree().change_scene("res://World.tscn")


func stop_the_music():
	$MusicManager.stop_music()
	
func start_the_music():
	$MusicManager.start_music()
