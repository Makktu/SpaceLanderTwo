extends Area2D

var barrier_active = true


func _ready() -> void:
	$AnimatedSprite.playing = true
	$AnimatedSprite2.playing = true
	

func _on_ShimmeringBarrier_body_entered(body):
	if body.name == 'player' and barrier_active:
		$"/root/Global".taking_damage = true


func _on_VisibilityNotifier2D_screen_entered():
	print("barrier notifier ENTER")
	$AnimatedSprite.playing = true
	$AnimatedSprite2.playing = true
	visible = true


func _on_VisibilityNotifier2D_screen_exited():
	print("barrier notifier EXIT")
	$AnimatedSprite.playing = false
	$AnimatedSprite2.playing = false
	visible = false
	
	
func _lightning_active():
	barrier_active = false
	visible = false
	$RestoreBarrierTimer.wait_time = $"/root/Global".random_float_number(10, 20)
	$RestoreBarrierTimer.start()
	

func _on_RestoreBarrierTimer_timeout():
	barrier_active = true
	$AnimatedSprite.playing = true
	$AnimatedSprite2.playing = true
	visible = true
