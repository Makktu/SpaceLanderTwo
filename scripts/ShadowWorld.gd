extends Node2D

var world_shaking = false

#func _process(delta):
#	if $"/root/Global".lightning_weapon_active and !world_shaking:
#		world_shaking = true
#		visible = true
#		$AnimationPlayer.play("lightning")
#		$ShakingTimer.start()
#
#func _on_ShakingTimer_timeout():
#	$AnimationPlayer.stop()
#	visible = false
#	world_shaking = false
