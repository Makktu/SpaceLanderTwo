extends KinematicBody2D

export var speed: float = 700
var velocity = Vector2(0, speed)

onready var bulletBurst = preload("res://scenes/BulletBurst.tscn")
var bullet_position
var bullet_impacting = false

# to be used for pickups that increase bullet speed
var increased_speed = false

func _ready() -> void:
	velocity = velocity.rotated(deg2rad(global_rotation_degrees))
	$LifetimeTimer.start()


func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
		var collided_with = collision_info.collider.name.left(5)
		var bulletImpact = bulletBurst.instance()
		get_tree().get_root().get_node("World/Test_Line_Env1").add_child(bulletImpact)
		bulletImpact.global_position.x = global_position.x
		bulletImpact.global_position.y = global_position.y
		if collided_with == "Enemy" or collided_with == "@Enem" or collided_with == "Bulle":
			queue_free()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


func _on_LifetimeTimer_timeout():
	queue_free()
