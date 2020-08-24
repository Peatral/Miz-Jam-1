extends TextureButton

class_name ToggleSound

var textureOn = preload("res://textures/Sound1.png")
var textureOff = preload("res://textures/Sound2.png")

func _ready():
	connect("focus_entered", self, "onFocusEnter")
	connect("focus_exited", self, "onFocusExit")
	connect("pressed", self, "onPressed")
	
	updateTexture()
	onFocusExit()

func onFocusEnter():
	modulate = Color("ffffff")

func onFocusExit():
	modulate = Color("cfc6b8")

func onPressed():
	Settings.mute = !Settings.mute
	updateTexture()

func updateTexture():
	texture_normal = textureOff if Settings.mute else textureOn
