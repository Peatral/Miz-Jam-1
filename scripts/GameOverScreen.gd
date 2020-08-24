extends Control

func _ready():
	visible = false

func showScreen(score):
	if score > Settings.score:
		$Margin/CenterScore/VBox/NewHighscore.visible = true
		Settings.score = score
	$Margin/CenterScore/VBox/Score.text = "%d" % score
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	get_parent().get_node("PauseScreen").disabled = true
	
	$Audio.play()
	$Timer.start()

func onRetryPressed():
	$Audio.stop()
	SceneSwitcher.changeScene("reload")

func onReturnToMenuPressed():
	$Audio.stop()
	SceneSwitcher.changeScene("menu")

# ----- If you click too fast the screen will go away -----
func onTimerTimeout():
	$Margin/Center/VBox/Retry.grab_focus()
