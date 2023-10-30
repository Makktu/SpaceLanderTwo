extends Node2D

onready var spoke_one = $AnimatedSprite
onready var spoke_two = $AnimatedSprite2
onready var spoke_three = $AnimatedSprite3
onready var spoke_four = $AnimatedSprite4

var starting_scale = 0.3
var max_scale = 0.8
var min_scale = 0.2

func _physics_process(_delta):
	var spoke_may_change = $"/root/Global".random_float_number(1,10)
	if spoke_may_change > 5:
		spoke_one_change()
		spoke_two_change()
		spoke_three_change()
		spoke_four_change()

func spoke_one_change():
	spoke_one.scale.y += $"/root/Global".random_float_number(-0.5, 0.5)
	if spoke_one.scale.y >= max_scale or spoke_one.scale.y <= min_scale:
		spoke_one.scale.y = starting_scale		
	
func spoke_two_change():
	spoke_two.scale.y += $"/root/Global".random_float_number(-0.5, 0.5)
	if spoke_two.scale.y >= max_scale or spoke_two.scale.y <= min_scale:
		spoke_two.scale.y = starting_scale
	
func spoke_three_change():
	spoke_three.scale.y += $"/root/Global".random_float_number(-0.5, 0.5)
	if spoke_three.scale.y >= max_scale or spoke_three.scale.y <= min_scale:
		spoke_three.scale.y = starting_scale
	
func spoke_four_change():
	spoke_four.scale.y += $"/root/Global".random_float_number(-0.5, 0.5)
	if spoke_four.scale.y >= max_scale or spoke_four.scale.y <= min_scale:
		spoke_four.scale.y = starting_scale
