extends Control

var paused = false setget setPaused
var disabled = false

func _ready():
	hide()

func _input(event):
	if Input.is_action_just_pressed("game_pause") && !disabled:
		self.paused = !get_tree().paused

func setPaused(val):
	if !disabled:
		paused = val
		get_tree().paused = paused
		visible = paused
		
		if paused && !$BGMusic.playing:
			$BGMusic.play()
		$BGMusic.stream_paused = !paused
		
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if paused else Input.MOUSE_MODE_HIDDEN)
		
		if paused:
			$Margin/Center/VBox/Resume.grab_focus()
		

func onResumePressed():
	if !disabled:
		setPaused(false)

func onReturnToMenuPressed():
	if !disabled:
		$BGMusic.stop()
		SceneSwitcher.changeScene("menu")
		disabled = true


