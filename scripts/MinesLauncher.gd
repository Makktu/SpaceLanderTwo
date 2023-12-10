extends Sprite


onready var basic_enemy = preload("res://scenes/Enemy1.tscn")
onready var fast_enemy = preload("res://scenes/Enemy2_Boom.tscn")
onready var boss_enemy = preload("res://scenes/Enemy3_Boss.tscn")

var already_triggered = false
var amount_spawned = 0
var amount_to_be_spawned
var spawn_wait_time
var lightning_stopped_us = false

func _physics_process(_delta):
	if $"/root/Global".lightning_weapon_active and already_triggered:
		$AnimatedSprite.stop()
		$AnimatedSprite.visible = false
		$DormancyTimer.wait_time = 15
		lightning_stopped_us = true
		$DormancyTimer.start()
	if $SpawnTimer.time_left > 0:
		$AnimatedSprite.scale.y += 0.00025

func spawn_mine():
	var which_enemy = $"/root/Global".random_float_number(1, 10)
	var loaded_enemy
	if which_enemy <= 9.5:
		loaded_enemy = basic_enemy.instance()
	if !loaded_enemy:
		loaded_enemy = fast_enemy.instance()
	get_node("spawn_node").add_child(loaded_enemy)

	

func _on_Area2D_body_entered(body):
	if !$"/root/Global".debug_enemies_on:
		return
	if body.name == 'player' and !already_triggered:
		already_triggered = true
		amount_to_be_spawned = $"/root/Global".global_amount_to_be_spawned
		spawn_wait_time = $"/root/Global".global_spawn_delay
		$SpawnTimer.wait_time = spawn_wait_time
		$AnimatedSprite.visible = true
		$AnimatedSprite.play("launching_sparky")
		$SpawnTimer.start()


func _on_SpawnTimer_timeout():
	if lightning_stopped_us:
		return
	amount_spawned += 1
	if amount_spawned < amount_to_be_spawned:
		spawn_mine()
		$AnimatedSprite.scale.y = 0.2
		$SpawnTimer.start()
	else:
		$AnimatedSprite.stop()
		$AnimatedSprite.visible = false
		$DormancyTimer.wait_time = 30
		$DormancyTimer.start()


func _on_DormancyTimer_timeout():
	# resets the spawner so it will trigger again if the player passes by
	if lightning_stopped_us:
		lightning_stopped_us = false
		$AnimatedSprite.visible = true
		$AnimatedSprite.play("launching_sparky")
		$SpawnTimer.start()
	else:
		already_triggered = false
		amount_spawned = 0
		amount_to_be_spawned += 2
		if amount_to_be_spawned > 30:
			amount_to_be_spawned = 30
