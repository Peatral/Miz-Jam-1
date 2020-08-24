extends Spatial

var score = 0 setget setScore
var combo = 1 setget setCombo

var scoreInternal = 0 setget setScoreInternal

var comboColors = [
	"56f21d",
	"a7f21d",
	"c7f21d",
	"ddf21d",
	"f2e41d",
	"f2cf1d",
	"f2b21d",
	"f2921d",
	"f2681d",
	"f2441d",
	"f21d1d"
]

var distanceCovered = 50.0 setget setDistanceCovered
var maximumDistance = 50.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	resetCombo()

func _process(delta):
	distanceCovered -= delta*2
	maximumDistance -= delta*.4

func resetCombo():
	self.combo = 1

func increaseCombo():
	self.combo = min(combo+1, 10)

func addEnemyToScore():
	self.score += 50*combo

func setDistanceCovered(val):
	distanceCovered = clamp(val, 0, maximumDistance)

func setScore(val):
	score = val
	$UI/FullScreen/Margin/Indicators/Score/Tween.interpolate_property(self, "scoreInternal", scoreInternal, score, .25, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$UI/FullScreen/Margin/Indicators/Score/Tween.start()

func setScoreInternal(val):
	scoreInternal = val
	$UI/FullScreen/Margin/Indicators/Score.text = "%d" % scoreInternal

func setCombo(val):
	combo = val
	$UI/FullScreen/Margin/Indicators/Combo.bbcode_text = "[right][color=#%s]%dx[/color][/right]" % [comboColors[combo], combo]
