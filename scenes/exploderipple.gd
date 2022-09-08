extends Panel

onready var anim = $animripple
func _ready():
	var t = Timer.new()
	t.set_wait_time(7.3)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	anim.play("ripple")
	t.queue_free()
