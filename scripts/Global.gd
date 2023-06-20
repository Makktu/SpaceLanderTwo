extends Node2D

var world_gravity : int = 5
var changed_gravity : int = 0

var collision_with_ground : bool = false
var in_gravity_trap : bool = false

var world_color_changed : bool = false
var world_color_now = ""

var game_over = false

func pause_or_game_over(state):
	if state == "pause":
		get_tree().paused = true
		
	if state == "unpause":
		get_tree().paused = false
		
	if state == "game_over":
		game_over = true
		get_tree().paused = true
		



