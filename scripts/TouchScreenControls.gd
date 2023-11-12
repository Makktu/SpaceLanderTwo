extends TouchScreenButton

class_name TouchScreenControls

signal double_tap
var tap_count = 1

var on_area = false

func _ready():
# warning-ignore:return_value_discarded
	self.connect("pressed", self, "_on_self_pressed")
# warning-ignore:return_value_discarded
	self.connect("released", self, "_on_self_released")
	
func get_swipe_direction(swipe, swipe_margin):
	var swipe_direction = Vector2.ZERO
	
	if swipe.x >= -swipe_margin and swipe.x <= swipe_margin and swipe.y >= swipe_margin:
		swipe_direction = Vector2.DOWN
	if swipe.x >= -swipe_margin and swipe.x <= swipe_margin and swipe.y <= -swipe_margin:
		swipe_direction = Vector2.UP
	if swipe.y >= -swipe_margin and swipe.y <= swipe_margin and swipe.x >= swipe_margin:
		swipe_direction = Vector2.RIGHT
	if swipe.y >= -swipe_margin and swipe.y <= swipe_margin and swipe.x <= -swipe_margin:
		swipe_direction = Vector2.LEFT
		
	if on_area:
		return swipe_direction
		
func _on_self_pressed():
	on_area = true
	tap_counter()
	
func _on_self_released():
	on_area = false

func tap_counter():
	if $TapTimer.time_left == 0:
		$TapTimer.start()
	else:
		tap_count += 1

	if tap_count >= 2:
		$TapTimer.stop()
		tap_count = 1		
		emit_signal("double_tap")
		print("TAPPED!")
