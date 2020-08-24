extends Position3D

export(NodePath) onready var target = get_node(target)

var offset = Vector2() setget setOffset
var amplitude = 0


func _process(delta):
	
	var targetPos = target.translation
	if target is Player:
		if target.moving || target.aiming:
			targetPos += target.dir*4
	$Tween.interpolate_property(self, "translation", translation, targetPos, 1.5, Tween.TRANS_CUBIC, Tween.EASE_OUT_IN)
	$Tween.start()



#----- SHAKER -----

func start(duration=.2, frequency=20, amplitude=.5):
	self.amplitude = amplitude

	$Frequency.wait_time = 1/float(frequency)
	$Duration.wait_time = duration

	$Frequency.start()
	$Duration.start()

	newShake()

func newShake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)

	$ShakeTween.interpolate_property(self, "offset", offset, rand, $Frequency.wait_time, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$ShakeTween.start()

func reset():
	$ShakeTween.interpolate_property(self, "offset", offset, Vector2(), $Frequency.wait_time, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$ShakeTween.start()

func onFrequencyTimeout():
	newShake()

func onDurationTimeout():
	reset()
	$Frequency.stop() 

func setOffset(val):
	offset = val
	$Camera.h_offset = offset.x
	$Camera.v_offset = offset.y
