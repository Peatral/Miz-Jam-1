extends Control

var entered = false
var credits = false
var help = false

var lastanim = ""

func _ready():
	get_parent().get_parent().get_node("Sprite/Center/Score").text = "%d" % Settings.score
	SceneSwitcher.connect("sceneChanged", self, "sceneChanged")

func _unhandled_input(event):
	if !entered && (event is InputEventJoypadButton || event is InputEventKey):
		entered = true
		$CenterContainer/Start.visible = false
		$CenterContainer/Menu.visible = true
		
		get_tree().set_input_as_handled()
		
		$CenterContainer/Menu/HBox/Enter.grab_focus()


func onEnterPressed():
	$BGMusic.stop()
	SceneSwitcher.changeScene("test")

func onQuitPressed():
	$BGMusic.stop()
	SceneSwitcher.changeScene("quit")

func onCreditsPressed():
	credits = !credits
	if help:
		help = false
	get_parent().get_parent().get_node("Camera2D").tweenToScreen(Vector2(0, 600) if credits else Vector2())

func onHelpPressed():
	help = !help
	if credits:
		credits = false
	
	if help:
		var node = get_parent().get_parent().get_node("TextContainer2/Tutorial").get_v_scroll()
		node.focus_mode = Control.FOCUS_ALL
		node.focus_neighbour_right = node.get_path_to($CenterContainer/Menu/HBox2/Help)
		$CenterContainer/Menu/HBox/Enter.focus_neighbour_left = $CenterContainer/Menu/HBox/Enter.get_path_to(node)
		$CenterContainer/Menu/HBox2/Help.focus_neighbour_left = $CenterContainer/Menu/HBox2/Help.get_path_to(node)
	else:
		$CenterContainer/Menu/HBox/Enter.focus_neighbour_left = ""
		$CenterContainer/Menu/HBox2/Help.focus_neighbour_left = ""
	
	get_parent().get_parent().get_node("Camera2D").tweenToScreen(Vector2(0, -600) if help else Vector2())


func sceneChanged():
	$BGMusic.play()



