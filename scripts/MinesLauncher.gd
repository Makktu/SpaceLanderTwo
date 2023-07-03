extends Sprite


onready var basic_enemy = preload("res://scenes/Enemy1.tscn")
var already_triggered = false
var amount_spawned = 0


func spawn_mine():
	var loaded_enemy = basic_enemy.instance()
	get_node("spawn_node").add_child(loaded_enemy)

	

func _on_Area2D_body_entered(body):
	if body.name == 'player' and !already_triggered:
		already_triggered = true
#		$activation_animation.play("activation")
		$Particles2D.emitting = true
		$SpawnTimer.start()


func _on_SpawnTimer_timeout():

	amount_spawned += 1
	if amount_spawned < 4:
		spawn_mine()
		$SpawnTimer.start()
	else:
#		$activation_animation.stop()
		$Particles2D.emitting = false
