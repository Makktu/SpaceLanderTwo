extends RayCast2D

onready var line = $Line2D
onready var end = $end

var direction = 1

var max_distance_of_beam = 1100 # max distance the beam can extend

var can_fire_beam = true


func _ready() -> void:
	cast_to = Vector2(max_distance_of_beam, 0)
	
func _physics_process(delta: float) -> void:
	if $"/root/Global".lightning_weapon_active and can_fire_beam:
		visible = false
		can_fire_beam = false
		$HidingTimer2.start()
		return
	if !can_fire_beam:
		return
	if is_colliding():
		var collision_point = to_local(get_collision_point())
		var thing_collided_with = get_collider()
		if thing_collided_with.name == 'player' and !$"/root/Global".lightning_weapon_active and $"/root/Global".can_damage_player and $end.visible:			
			$"/root/Global".taking_damage = true
		line.points[1].x = collision_point.x
		end.position.x = collision_point.x - 10
	else:
		line.points[1].x = max_distance_of_beam
		end.position.x = max_distance_of_beam - 15


func start_beam() -> void:
	can_fire_beam = true
	$Line2D.visible = true
	$end.visible = true
	if $"/root/Global".sound_effects_on:
		$Sparking.play()
		

func _on_VisibilityNotifier2D_screen_entered():
	start_beam()
	

func _on_VisibilityNotifier2D_screen_exited():
	$starting_spark.visible = true
	if $Sparking.playing:
		$Sparking.stop()


func _on_HidingTimer2_timeout() -> void:
	can_fire_beam = true
	visible = true
