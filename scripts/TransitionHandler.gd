extends CanvasLayer

signal sceneChanged

func _ready():
	get_tree().paused = true
	$Animations.play_backwards("Fade")
	yield($Animations, "animation_finished")
	get_tree().paused = false
	emit_signal("sceneChanged")

func changeScene(scene : String, delay = 0.0):
	yield(get_tree().create_timer(delay), "timeout")
	$Animations.play("Fade")
	get_tree().paused = true
	yield($Animations, "animation_finished")
	match scene:
		"quit":
			get_tree().quit()
		"reload":
			get_tree().reload_current_scene()
		"menu":
			get_tree().change_scene("res://scenes/MainMenu.tscn")
		"test":
			get_tree().change_scene("res://scenes/Test.tscn")
		_:
			assert(get_tree().change_scene_to(load(scene)) == OK)
	$Animations.play_backwards("Fade")
	yield($Animations, "animation_finished")
	get_tree().paused = false
	emit_signal("sceneChanged")
