extends Control

onready var hoverS = $hover
onready var startS = $select
var hoveredOn = false
var startgame = false
var screenXsize = 0.0
var screensize = Vector2(screenXsize, 1080)
var playintro = true

func _ready():
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	$startsound.play()
	t.queue_free()

func _on_Exit_pressed():
	get_tree().quit()

func _on_Exit_mouse_entered():
	hoverS.play()
	$EXIT/hover.play("hoverExit")

func _on_Exit_mouse_exited():
	$EXIT/hover.play("hoverExit 2")

func _on_Start_pressed():
	if playintro:
		startgame = true
		startS.play()
		$OSTSTART/OST/fadeout.play("fadeout")
		var t2 = Timer.new()
		t2.set_wait_time(1)
		t2.set_one_shot(true)
		self.add_child(t2)
		t2.start()
		yield(t2, "timeout")
		get_tree().change_scene("res://scenes/intro.tscn")
		t2.queue_free()
	else:
		print("not first time, loading save file for later")
	

func _on_Start_mouse_entered():
	hoverS.play()
	hoveredOn = true
	$START/hover.play("hoverPlay")	

func _on_Start_mouse_exited():
	$START/hover.play("hoverPlay 2")
	
func _process(delta):
	if startgame == true:
		$startgamefade.set_size(screensize)
		screenXsize += delta * 5000
		screensize = Vector2(screenXsize, 1080)
		update()

