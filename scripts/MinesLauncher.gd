extends Sprite


onready var basic_enemy = preload("res://scenes/Enemy1.tscn")
var already_triggered = false
var amount_spawned = 0
var amount_to_be_spawned = 4


func spawn_mine():
	var loaded_enemy = basic_enemy.instance()
	get_node("spawn_node").add_child(loaded_enemy)

	

func _on_Area2D_body_entered(body):
	if !$"/root/Global".debug_enemies_on:
		return
	if body.name == 'player' and !already_triggered:
		already_triggered = true
		$activation_animation.play("activation")
		$SpawnTimer.start()


func _on_SpawnTimer_timeout():
	amount_spawned += 1
	if amount_spawned < amount_to_be_spawned:
		spawn_mine()
		$SpawnTimer.start()
	else:
		$activation_animation.stop()
		$DormancyTimer.start()


func _on_DormancyTimer_timeout():
	# resets the spawner so it will trigger again if the player passes by
	already_triggered = false
	amount_spawned = 0
	amount_to_be_spawned += 2
	if amount_to_be_spawned > 10:
		amount_to_be_spawned = 10
