extends KinematicBody2D

var speed = 60
var navagent : NavigationAgent2D
var target_position

onready var the_player = get_tree().get_nodes_in_group("player")[0]

func _ready():
	navagent = $NavigationAgent2D
	navagent.connect("velocity_computed", self, "_on_velocity_computed")
	$NavTimer.start()
	$AnimatedSprite.play("default")

	
func _physics_process(delta):
	if navagent.is_navigation_finished():
		return
	var target_position = navagent.get_next_location()
	var direction = global_position.direction_to(target_position)
#	global_position += direction * speed * delta
#	target_position = (the_player.global_position - global_position).normalized()
	var velocity = direction * navagent.max_speed	
	move_and_slide(velocity)


func _on_ExtinctionTimer_timeout():
	$explosion.visible = true
	$AnimatedSprite.visible = false
	$explosion.play("explode")
	yield($explosion, "animation_finished")
	queue_free()
	

func _on_velocity_computed(velocity):
	print("???")
	pass
	

func _on_NavTimer_timeout() -> void:
	var player_position = the_player.global_position
	navagent.set_target_location(player_position)
	$NavTimer.start()
	
func _on_Area2D_body_entered(body):
	if body.name == "player":
		navagent.max_speed *= 4
		$DelayTimer.start()

		
		
func _on_DelayTimer_timeout():
	_on_ExtinctionTimer_timeout()

####################################################
#		if currentWaypointIndex >= path.size():
#			path.clear()
#			currentWaypointIndex = 0
	
#	if $"/root/Global".pulser_fired:
#		distance_to_player = the_player.global_position.distance_to(global_position)
#		if distance_to_player < 120:
#			pulser_damage()
			



		
#func pulser_damage():
#	$"/root/Global".enemies_chasing_player -= 1
#	$AnimatedExplosion.visible = true
#	$AnimatedSprite.visible = false
#	$AnimatedExplosion.play("explode")
#	yield($AnimatedExplosion, "animation_finished")
#	queue_free()


