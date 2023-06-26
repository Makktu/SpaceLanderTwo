extends Sprite


onready var basic_enemy = preload("res://scenes/Enemy1.tscn")
var already_triggered = false


func spawn_mine():
	var loaded_enemy = basic_enemy.instance()
	get_node("spawn_node").add_child(loaded_enemy)
	$activation_animation.stop()
	

func _on_Area2D_body_entered(body):
	if body.name == 'player' and !already_triggered:
		$activation_animation.play("activation")
		$SpawnTimer.start()


func _on_SpawnTimer_timeout():
	already_triggered = true
	spawn_mine()
