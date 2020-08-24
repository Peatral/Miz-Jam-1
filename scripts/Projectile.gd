tool
extends Area

export var color = Color(1,1,1,1) setget setColor
export(int, 0, 3) var type = 0

var dir = Vector3()
var speed = 10
var mat : SpatialMaterial

var moving = true setget setMoving

func _ready():
	mat = $SpriteOrigin/Sprite.material_override.duplicate()
	setType(type)

func _physics_process(delta):
	if moving:
		translation += dir*speed*delta

func setColor(val):
	color = val
	
	if mat != null && get_child_count() > 0:
		mat.emission = color
		mat.albedo_color = color
		
		$SpriteOrigin/Sprite.material_override = mat
		$Particles.material_override = mat
		$Explosion.material_override = mat

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

func tweenOut():
	$Tween.interpolate_property(self, "color", color, Color(0,0,0,0), .3, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.start()

func shake():
	get_parent().get_node("CameraOrigin").start()

func _on_Timer_timeout():
	explode()

func on_body_entered(body : Node):
	if body.is_in_group("enemy"):
		explode()
		if body.type == type:
			body.queue_free()
			get_parent().increaseCombo()
			get_parent().addEnemyToScore()
		else:
			get_parent().resetCombo()

func explode():
	$CollisionShape.disabled = true
	$AnimationPlayer.play("Explode")

func setMoving(val):
	moving = val
