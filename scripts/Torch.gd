extends Spatial


var default = 2
var diffrange = 1

var time = 1
var difftime = .4

func _ready():
	tweenLight()


func tweenLight():
	randomize()
	$Tween.interpolate_property($Light, "light_energy", $Light.light_energy, default + (randf()*2-1)*diffrange, time + (randf()*2-1)*difftime, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	tweenLight()
