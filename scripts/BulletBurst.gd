extends Node2D


func _ready():
	$CollisionSparkles.visible = true
	$CollisionSparkles.emitting = true
	$LifetimeTimer.start()


func _on_LifetimeTimer_timeout() -> void:
	queue_free()
