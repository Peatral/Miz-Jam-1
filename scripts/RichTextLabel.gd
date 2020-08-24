extends RichTextLabel

var focus = false

func _ready():
	get_v_scroll().connect("focus_entered", self, "vScrollFocusEnter")
	get_v_scroll().connect("focus_exited", self, "vScrollFocusExit")

func vScrollFocusEnter():
	modulate = Color("ffffff")
	focus = true

func vScrollFocusExit():
	modulate = Color("cfc6b8")
	focus = false

func _process(delta):
	if focus:
		if Input.is_action_pressed("ui_up"):
			get_v_scroll().value -= 5
		if Input.is_action_pressed("ui_down"):
			get_v_scroll().value += 5
