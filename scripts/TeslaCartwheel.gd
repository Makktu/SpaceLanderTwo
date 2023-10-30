extends Node2D

var rotation_speed = 0.001

# seconds before restarting following player weapon use
var reboot_after_lightning = 10

var cartwheel_disabled = false

func _ready():
	$VariationTimer.start()
	

func _physics_process(delta):
#	if cartwheel_disabled:
#		return
	rotation += rotation_speed
#	if $"/root/Global".lightning_weapon_active:
#		cartwheel_disabled = true
#		disable_cartwheel()

func disable_cartwheel():
	$TeslaBeam.visible = false
	$TeslaBeam2.visible = false
	$TeslaBeam3.visible = false
	$TeslaBeam4.visible = false
	$RestoreAfterLightningTimer.wait_time = reboot_after_lightning
	$RestoreAfterLightningTimer.start()
	

func _on_VariationTimer_timeout():
	rotation_speed += $"/root/Global".random_float_number(-0.003, 0.003)
	rotation_speed = -rotation_speed
	if rotation_speed < -0.003:
		rotation_speed = -0.003
	if rotation_speed > 0.003:
		rotation_speed = 0.003
	$VariationTimer.start()


func _on_RestoreAfterLightningTimer_timeout():
	$TeslaBeam.visible = true
	$TeslaBeam2.visible = true
	$TeslaBeam3.visible = true
	$TeslaBeam4.visible = true
	cartwheel_disabled = false
