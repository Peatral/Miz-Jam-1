extends HBoxContainer

var hearts = 3 setget setHearts
var hp = 6 setget setHP

class_name UIElementHPBar

func _ready():
	self.hearts = 3
	self.hp = 6


func setHearts(val):
	hearts = max(val, 1)
	for child in get_children():
		if child is UIElementHeart:
			child.queue_free()
	for i in hearts:
		var heart = UIElementHeart.new()
		add_child(heart)

func setHP(val):
	hp = clamp(val, 0, 2*hearts)
	var hpHelper = hp
	var idx = 0
	for child in get_children():
		if hpHelper >= 2:
			child.type = 2
			hpHelper -= 2
		else:
			child.type = hpHelper
			hpHelper = 0
