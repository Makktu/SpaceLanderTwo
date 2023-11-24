extends CanvasLayer

var shaken = 0

func _ready() -> void:
	show_lightning()
	show_shield()

func show_lightning():
	$Lightning.visible = true
	$Lightning/Particles2D.emitting = true
	
func hide_lightning():
	$Lightning.visible = false
	$Lightning/Particles2D.emitting = false
	
func show_shield():
	$Shield.visible = true
	$Shield/Particles2D.emitting = true
	
func hide_shield():
	$Shield.visible = false
	$Shield/Particles2D.emitting = false
	
func shake_shield():
	$AnimationPlayer.play("shake_shield")

func show_speed_boost():
	$SpeedBoost.visible = true
	$SpeedBoost.play("boost")
	$SpeedBoost/Particles2D.emitting = true
	
func hide_speed_boost():
	$SpeedBoost.visible = false
	$SpeedBoost.stop()
	$SpeedBoost/Particles2D.emitting = false


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "shake_shield" and shaken < 5:
		shaken += 1
		shake_shield()
	else:
		shaken = 0
