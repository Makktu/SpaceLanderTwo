extends CanvasLayer

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
	
	
