extends ColorRect

var RGB = 0
var ALPHA = 1
var timer = 0

func _ready():
	pass
	
func _process(delta):
	$".".color = Color(RGB, RGB, RGB, ALPHA) # Set ColorRect's color
	timer += delta
	if not timer > 1:
		pass
	elif not timer > 3:
		RGB += delta
		update()
	else:
		if not ALPHA < 0:
			ALPHA -= delta
			update()
			if ALPHA < 0:
				ALPHA = 0
				$".".hide()
