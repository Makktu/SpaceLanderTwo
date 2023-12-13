extends KinematicBody2D

var navagent : NavigationAgent2D
var speed = 150
var target_position

var this_enemy_on_screen = true
var lightning_dealt = false
var this_enemy_shot = false

var move_up_complete = false # enemy will move up (relative to its spawn point) for 2 seconds before the path-finding/ player-hunting script begins

onready var the_player = get_tree().get_nodes_in_group("player")[0]

func _ready():
	navagent = $NavigationAgent2D
	navagent.connect("velocity_computed", self, "_on_velocity_computed")
	$NavTimer.start()
	$Anim_sparky.play("sparky")
	$move_up_timer.start()

	
func _physics_process(delta):
	if !move_up_complete:
		position.y -= 0.25
		return
	if navagent.is_navigation_finished():
		return
	var target_position = navagent.get_next_location()
	var direction = global_position.direction_to(target_position)
	var velocity = direction * navagent.max_speed	
	move_and_slide(velocity)
	$Anim_sparky.rotation_degrees += 0.25
	if $Anim_sparky.rotation_degrees >= 360:
		$Anim_sparky.rotation_degrees = 0


func _on_ExtinctionTimer_timeout():
	if $"/root/Global".lightning_weapon_active and !this_enemy_on_screen:
		return
	if $"/root/Global".lightning_weapon_active and !lightning_dealt:
		lightning_dealt = true
		lightning_death()
	else:
	#	$Anim_sparky.scale.x *= 3
	#	$Anim_sparky.scale.y *= 3	
		$explosion.visible = true
		$AnimatedSprite.visible = false
		$explosion.play("explode")
		# work out how far away exploding mine is from player
		# and inflict damage if player within blast radius
		if !this_enemy_shot:
			# mine exploding cannot damage player if shot
			var player_position = the_player.global_position
			var mine_position = global_transform.origin
			var distance_from_player = player_position.distance_to(mine_position)
			if distance_from_player <= 175 and !$"/root/Global".lightning_weapon_active:
				# _____________________^^^ this
				# is the value for when the explosion affects the player
				$"/root/Global".taking_damage = true
		yield($explosion, "animation_finished")
		# calc random value for damage based on proximity
		
		if $"/root/Global".taking_damage:
			$"/root/Global".player_damaged(1)
						
		queue_free()
	

func _on_NavTimer_timeout() -> void:
	var player_position = the_player.global_position
	navagent.set_target_location(player_position)
	$NavTimer.start()
	
	
func _on_Area2D_body_entered(body):
	if body.name == "player":
		navagent.max_speed *= 8
		$DelayTimer.start()
	if body.name == "end" and move_up_complete:
		_on_ExtinctionTimer_timeout()
		
func _on_DelayTimer_timeout():
	_on_ExtinctionTimer_timeout()


func _on_move_up_timer_timeout():
	$AnimatedSprite.play("default")
	$Area2D.monitoring = true
	move_up_complete = true


func _on_VisibilityNotifier2D_screen_exited():
	this_enemy_on_screen = false


func _on_VisibilityNotifier2D_screen_entered():
	this_enemy_on_screen = true


func _on_Area2D_ForTesla_area_entered(area):
	if area.name == "BulletArea" and move_up_complete:
		this_enemy_shot = true
		_on_ExtinctionTimer_timeout()
	if area.name == 'end' and move_up_complete:
		_on_ExtinctionTimer_timeout()
	
func lightning_death():
	$LightningDeathTimer.wait_time = $"/root/Global".random_float_number(0.1, 1.4)
	$LightningDeathTimer.start()
	
func _on_LightningDeathTimer_timeout():
	_on_ExtinctionTimer_timeout()
