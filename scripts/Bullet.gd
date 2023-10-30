extends KinematicBody2D

export var speed: float = 700
var velocity = Vector2(0, speed)

# to be used for pickups that increase bullet speed
var increased_speed = false

func _ready() -> void:
	velocity = velocity.rotated(deg2rad(global_rotation_degrees))
	$LifetimeTimer.start()


func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
#		$CollisionSparkles.visible = true
#		$CollisionSparkles.emitting = true
		velocity = velocity.bounce(collision_info.normal)
		var collided_with = collision_info.collider.name.left(5)
		if collided_with == "Enemy" or collided_with == "@Enem" or collided_with == "Bulle":
			queue_free()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


func _on_LifetimeTimer_timeout():
	queue_free()


func _on_BulletArea_body_entered(body):
	print(body.name)
