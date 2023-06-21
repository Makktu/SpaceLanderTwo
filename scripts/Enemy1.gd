extends KinematicBody2D

var speed = 60

var target_position

var distance_to_player

onready var the_player = get_tree().get_nodes_in_group("player")[0]


func _ready():
	$AnimatedSprite.play("default")
#	$AnimationPlayer.play("enemy_throb")
#	$"/root/Global".enemies_chasing_player += 1
#	_physics_process(true)

	
func _physics_process(_delta):
	target_position = (the_player.global_position - global_position).normalized()
	move_and_slide(target_position * speed)
#	if $"/root/Global".pulser_fired:
#		distance_to_player = the_player.global_position.distance_to(global_position)
#		if distance_to_player < 120:
#			pulser_damage()
			

#func _on_Area2D_body_entered(body):
#	if body.name == "Player":
#		$"/root/Global".taking_damage = true
#		$"/root/Global".player_energy -= 10

		
#func pulser_damage():
#	$"/root/Global".enemies_chasing_player -= 1
#	$AnimatedExplosion.visible = true
#	$AnimatedSprite.visible = false
#	$AnimatedExplosion.play("explode")
#	yield($AnimatedExplosion, "animation_finished")
#	queue_free()

func _on_ExtinctionTimer_timeout():
	$explosion.visible = true
	$AnimatedSprite.visible = false
	$explosion.play("explode")
	yield($explosion, "animation_finished")
	queue_free()
