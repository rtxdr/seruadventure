extends AudioStreamPlayer

onready var ost = $OST

func _ready():
	var t2 = Timer.new()
	t2.set_wait_time(2.8)
	t2.set_one_shot(true)
	self.add_child(t2)
	t2.start()
	yield(t2, "timeout")
	self.play()
	t2.queue_free()
	var t = Timer.new()
	t.set_wait_time(1.7)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	ost.play()
	t.queue_free()
