extends Camera2D


var shakeySize = 10
var zoomOf = .1

var screenPos = Vector2() setget setScreenPos

func _ready():
	randomize()
	nextShake()

func nextShake():
	var newPos = Vector2(rand_range(-shakeySize, shakeySize), rand_range(-shakeySize, shakeySize))
	var randZoom = .5 + rand_range(-zoomOf, zoomOf)
	var newZoom = Vector2(randZoom, randZoom)
	var dur = newPos.distance_to(position)/2
	$Tween.interpolate_property(self, "position", position, newPos, dur, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(self, "zoom", zoom, newZoom, dur, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()

func tweenToScreen(val):
	$Tween.stop_all()
	$Tween.interpolate_property(self, "screenPos", screenPos, val, .75, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.start()

func setScreenPos(val):
	screenPos = val
	position = screenPos

func onTweenCompleted(object, key):
	if key == ":zoom" || key == ":screenPos":
		nextShake()
