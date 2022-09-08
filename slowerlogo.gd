extends Sprite

var alphaB = 0
var alphaA = 0
var timer = 0

func _ready():
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	$"../startsound".play()
	t.queue_free()
	
func _process(delta):
	$".".modulate = Color(1, 1, 1, alphaA) # Set ColorRect's color to red.
	$slowerlogo2.modulate = Color(1,1,1, alphaB)
	timer += delta
	if timer < 1:
		pass
	elif timer < 2:
		if alphaA < 1:
			alphaA += delta * 2
	elif timer < 3:
		if alphaB < 1:
			alphaB += delta * 2
	elif timer < 4:
		alphaA -= delta
		alphaB -= delta
	elif timer < 6:
		$".".hide()
