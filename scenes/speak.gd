extends Control

var rng = RandomNumberGenerator.new()
var speakpitchrng = speakpitch
var speakskip = false
var speakstate = 0
# speakstate 0 : Not speaking, box not in game or shown.
# speakstate 1 : Currently speaking.
# speakstate 2 : Finished speaking.
var speechstringL = ""
var speechstringIND = ""
var speechstringLEN = 0
var dialoguelevel = 0

onready var textbox = $TEXT
onready var speak = $"."

############################################
# VOICE PITCH (DEF 1)
var speakpitch = 1
#
# VOICE PITCH VARIATION SCALE (DEF 0.3)
var speakpitchscale = 0.3
#
#$exitdialog : quit dialogue
#µ : wait a bit
#
# WHAT SHOULD THE CHARACTER SAY (always add space at end pls)
var speechstring = ["Wµhµ-µµµµµµµµµµµµµµµ Wµhµeµrµeµµ aµmµµ iµ?",
"$exitdialog"]
#
# SPEAKING SPEED (DEF 0.05)
var speakspeed = 0.05
################## VOICE ###################
onready var voice = $voice
############################################

func speakit():
	if speechstring[dialoguelevel] == "$exitdialog":
		speak.hide()
		return
	speechstringIND = speechstring[dialoguelevel]
	speechstringLEN = speechstring[dialoguelevel].length()
	for n in range(speechstringLEN):
		if speakskip:
			textbox.clear()
			textbox.text = speechstring[dialoguelevel]
			speakstate = 2
			speakskip = false
			return
		if speakstate == 2:
			textbox.clear()
			textbox.text = speechstring[dialoguelevel]
			return
		speechstringL = speechstring[dialoguelevel][n]
		
		if speechstringIND == "µ":
			var tna = Timer.new()
			tna.set_wait_time(0.5)
			tna.set_one_shot(true)
			self.add_child(tna)
			tna.start()
			yield(tna, "timeout")
			tna.queue_free()
			return
		#speak speed wait
		var t = Timer.new()
		t.set_wait_time(speakspeed)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		
		#random pitch for voice
		rng.randomize()
		if speechstringL == " ":
			pass
		elif speechstringL == "µ":
			pass
		else:
			speakpitchrng = speakpitch + rng.randf_range(-(speakpitchscale), speakpitchscale)
			voice.pitch_scale = speakpitchrng
			voice.play()
			speakpitchrng = speakpitch
		
		if not speechstringL == "µ":
			textbox.add_text(speechstringL)
		update()
		if n == speechstringLEN-1:
			speakstate = 2

func _ready():
	speak.hide()
	voice.pitch_scale = speakpitch
	rng.randomize()
	
	var t2 = Timer.new()
	t2.set_wait_time(1)
	t2.set_one_shot(true)
	self.add_child(t2)
	t2.start()
	yield(t2, "timeout")
	speak.show()
	speakstate = 1
	speakit()
	t2.queue_free()

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if not event.scancode == KEY_ESCAPE:
				if speakstate == 1:
					speakskip = true
				if speakstate == 2:
					dialoguelevel += 1
				else:
					return
				textbox.clear()
				speak.show()
				speakstate = 1
				speakit()
