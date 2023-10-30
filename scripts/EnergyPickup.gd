extends Area2D


func _ready() -> void:
	$AnimationPlayer.play("glow")


func _on_EnergyPickup_body_entered(body):
	if body.name == 'player':
		$AnimationPlayer.play("picked_up")
		yield($AnimationPlayer, "animation_finished")
		queue_free()
