tool
extends TextureRect

class_name UIElementHeart

export(int, "Empty", "Half", "Full") var type = 0 setget setType

func _ready():
	rect_size = Vector2(64, 64)
	rect_min_size = Vector2(64, 64)
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
	size_flags_horizontal = SIZE_EXPAND_FILL
	size_flags_vertical = SIZE_EXPAND_FILL
	
	self.type = 0

func setType(val):
	type = clamp(val, 0, 2)
	match type:
		0:
			texture = preload("res://textures/Heart1.png")
		1:
			texture = preload("res://textures/Heart2.png")
		2:
			texture = preload("res://textures/Heart3.png")
