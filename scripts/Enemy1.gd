extends KinematicBody2D

var speed = 60
var navagent : NavigationAgent2D
var target_position

var move_up_complete = false # enemy will move up (relative to its spawn point) for 2 seconds before the path-finding/ player-hunting script begins

onready var the_player = get_tree().get_nodes_in_group("player")[0]

func _ready():
	navagent = $NavigationAgent2D
	navagent.connect("velocity_computed", self, "_on_velocity_computed")
	$NavTimer.start()
	$AnimatedSprite.play("default")
	$move_up_timer.start()

	
func _physics_process(delta):
	if !move_up_complete:
		position.y -= 0.25
		return
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
	# work out how far away exploding mine is from player
	# and inflict damage if player within blast radius
	var player_position = the_player.global_position
	var mine_position = global_transform.origin
	var distance_from_player = player_position.distance_to(mine_position)
	print(">>>", distance_from_player)
	if distance_from_player <= 175:
		# _____________________^^^ this
		# is the value for when the explosion affects the player
		$"/root/Global".taking_damage = true
	yield($explosion, "animation_finished")
	# calc random value for damage based on proximity
	print("<<<", the_player.shields)
	if distance_from_player > 99 and distance_from_player <= 175:
		the_player.shields -= RandomNumberGenerator.new().randf_range(4.0, 8.0)
	else:
		if distance_from_player <= 100:
			the_player.shields -= RandomNumberGenerator.new().randf_range(8.0, 12.0)
	print(">>>", the_player.shields)		
	queue_free()
	

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


func _on_move_up_timer_timeout():
	$Area2D.monitoring = true
	move_up_complete = true
