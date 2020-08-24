extends KinematicBody


export var color = Color(1,1,1,1) setget setColor
export(int, 0, 3) var type = 0

var mat : SpatialMaterial

var player : Player

var speed = 2.5

func _ready():
	mat = $SpriteOrigin/Sprite.material_override.duplicate()
	scramble()

func _physics_process(delta):
	var playerPos = player.translation
	var pos = translation
	
	var dir = (playerPos-pos).normalized()
	$Ray.cast_to = dir*1
	
	if $Ray.is_colliding() && $Ray.get_collider() is Player:
		$Ray.get_collider().hp -= 1
		get_parent().resetCombo()
		queue_free()
	
	move_and_slide(dir*speed, Vector3.UP)

func setColor(val):
	color = val
	
	if mat != null && get_child_count() > 0:
		mat.emission = color
		mat.albedo_color = color
		
		$SpriteOrigin/Sprite.material_override = mat

func setType(val):
	type = val
	$SpriteOrigin/Sprite.frame = type
	match(val):
		0:
			self.color = Color.red
		1:
			self.color = Color.green
		2:
			self.color = Color.blue
		3:
			self.color = Color.orange

func scramble():
	setType(randi()%4)
