extends Area2D

func _ready():
	$AnimationPlayer.play("rotate")

func _on_GravityTrap_body_entered(body):
	if body.name == 'player':
		$"/root/Global".in_gravity_trap = true
#		$"/root/Global".changed_gravity = 50


func _on_GravityTrap_body_exited(body):
	if body.name == 'player':
		$"/root/Global".in_gravity_trap = false
#		$"/root/Global".changed_gravity = $"/root/Global".world_gravity
