extends Node2D

onready var basic_enemy = preload("res://scenes/Enemy1.tscn")
var already_triggered = false
var amount_spawned = 0

func start_spawning():
	print("SPAWN!!", amount_spawned)
#	amount_spawned += 1
#	var loaded_enemy = basic_enemy.instance()
#	get_parent().get_node("SpawnPoint1").add_child(loaded_enemy)
#	if amount_spawned < 25:
#		$SpawnTimer.start()
	

func _on_SpawnTimer_timeout() -> void:
	print('timer!')
	start_spawning()


func _on_Area2D_body_entered(body):
	if !already_triggered and body.name == 'player':
		already_triggered = true
		start_spawning()
