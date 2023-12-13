extends Node2D

onready var spoke_one = $Lightning1/AnimatedSprite
onready var spoke_two = $Lightning2/AnimatedSprite2
onready var spoke_three = $Lightning3/AnimatedSprite3
onready var spoke_four = $Lightning4/AnimatedSprite4

var starting_scale = 0.3
var max_scale = 10
var min_scale = 0.2

# tentacles cannot damage player until creature
# is fully emerged from spawner
var tentacles_can_damage_player = false


func _physics_process(delta):
	var spoke_may_change = $"/root/Global".random_float_number(1,10)
	if spoke_may_change > 5:
		spoke_one_change()
		spoke_two_change()
		spoke_three_change()
		spoke_four_change()
		
func tentacles_shrink(shrink):
	# shrink is bool
	if shrink:
		max_scale = 2
		min_scale = 0.06 
	else:
		max_scale = 10
		min_scale = 0.2

func spoke_one_change():
	var expand_by = $"/root/Global".random_float_number(-0.5, 0.5)
	spoke_one.scale.y += expand_by
	$Lightning1/CollisionShape2D.scale.y += expand_by
	if spoke_one.scale.y >= max_scale or spoke_one.scale.y <= min_scale:
		spoke_one.scale.y = starting_scale
		$Lightning1/CollisionShape2D.scale.y = starting_scale
	
func spoke_two_change():
	var expand_by = $"/root/Global".random_float_number(-0.5, 0.5)
	spoke_two.scale.y += expand_by
	$Lightning2/CollisionShape2D2.scale.y += expand_by
	if spoke_two.scale.y >= max_scale or spoke_two.scale.y <= min_scale:
		spoke_two.scale.y = starting_scale
		$Lightning2/CollisionShape2D2.scale.y = starting_scale
	
func spoke_three_change():
	var expand_by = $"/root/Global".random_float_number(-0.5, 0.5)
	spoke_three.scale.y += expand_by
	$Lightning3/CollisionShape2D3.scale.y += expand_by
	if spoke_three.scale.y >= max_scale or spoke_three.scale.y <= min_scale:
		spoke_three.scale.y = starting_scale
		$Lightning3/CollisionShape2D3.scale.y = starting_scale
	
func spoke_four_change():
	var expand_by = $"/root/Global".random_float_number(-0.5, 0.5)
	spoke_four.scale.y += expand_by
	$Lightning4/CollisionShape2D4.scale.y += expand_by
	if spoke_four.scale.y >= max_scale or spoke_four.scale.y <= min_scale:
		spoke_four.scale.y = starting_scale
		$Lightning4/CollisionShape2D4.scale.y = starting_scale


func _on_Lightning1_body_entered(body):
	if body.name == 'player' and tentacles_can_damage_player:
		$"/root/Global".tentacle_struck = true
		$"/root/Global".player_damaged(0.2)


func _on_Lightning2_body_entered(body):
	if body.name == 'player' and tentacles_can_damage_player:
		$"/root/Global".tentacle_struck = true
		$"/root/Global".player_damaged(0.2)


func _on_Lightning3_body_entered(body):
	if body.name == 'player' and tentacles_can_damage_player:
		$"/root/Global".tentacle_struck = true
		$"/root/Global".player_damaged(0.2)			


func _on_Lightning4_body_entered(body):
	if body.name == 'player' and tentacles_can_damage_player:
		$"/root/Global".tentacle_struck = true
		$"/root/Global".player_damaged(0.2)
