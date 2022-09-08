extends Sprite

onready var path = get_parent()
var speed = 70
var flying = true

func _ready():
	
	var t = Timer.new()
	t.set_wait_time(8)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	flying = false
	$AnimationPlayer.play('shake')
	$"../../../Node2D".show()
	$"../../../Node2D/explodesound".play()
	t.queue_free()
	
	var t2 = Timer.new()
	t2.set_wait_time(3)
	t2.set_one_shot(true)
	self.add_child(t2)
	t2.start()
	yield(t2, "timeout")
	$"../../../endfade/endfadeanim".play('endfadeanim')
	t2.queue_free()
	
	var t3 = Timer.new()
	t3.set_wait_time(3)
	t3.set_one_shot(true)
	self.add_child(t3)
	t3.start()
	yield(t3, "timeout")
	get_tree().change_scene("res://scenes/game/c1/p1.tscn")
	t3.queue_free()

func _process(delta):
	if flying:
		path.set_offset(path.get_offset() + speed * delta)
