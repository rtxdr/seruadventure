extends ColorRect

var timer = 0
var start = false
var screenXsize = 1920
var screensize = Vector2(screenXsize, 1080)

func _ready():
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	start = true
	$"../spacesong".play()
	t.queue_free()
	var t2 = Timer.new()
	t2.set_wait_time(7)
	t2.set_one_shot(true)
	self.add_child(t2)
	t2.start()
	yield(t2, "timeout")
	start = true
	$"../spacesong".stop()
	t2.queue_free()
	
func _process(delta):
	if start == true:
		$".".set_size(screensize)
		screenXsize -= delta * 5000
		screensize = Vector2(screenXsize, 1080)
		update()
