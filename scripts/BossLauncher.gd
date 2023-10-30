extends Sprite

onready var boss_enemy = preload("res://scenes/Enemy3_Boss.tscn")

var already_triggered = false


func _physics_process(delta):
	if $SpawnTimer.time_left > 0:
		$AnimatedSprite.scale.y += 0.00025
		

func spawn_mine():
	var loaded_enemy
	loaded_enemy = boss_enemy.instance()
	get_node("spawn_node").add_child(loaded_enemy)

	

func _on_Area2D_body_entered(body):
	if !$"/root/Global".debug_enemies_on || already_triggered:
		return
	if body.name == 'player':
		already_triggered = true
		$AnimatedSprite.visible = true
		$AnimatedSprite.play("launching_sparky")
		$SpawnTimer.start()


func _on_SpawnTimer_timeout():
	spawn_mine()
	$AnimatedSprite.scale.y = 0.2
	$StopSpawnTimer.start()


func _on_DormancyTimer_timeout():
	# resets the spawner so it will trigger again if the player passes by
	already_triggered = false


func _on_StopSpawnTimer_timeout():
	$AnimatedSprite.stop()
	$AnimatedSprite.visible = false
	$DormancyTimer.start()
