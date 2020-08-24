extends KinematicBody

class_name Player

var vel = Vector3()

var maxHSpd = 3
var maxVSpd = 10

var lastSide = 1
var lastInputDirH = 1

var moving = false
var aiming = false

var dir = Vector3()
var lastDir = Vector3()

var projectileScene = preload("res://scenes/Projectile.tscn")


onready var hp = 6 setget setHP


func _ready():
	self.hp = 6


func _physics_process(delta):
	
	#Input direction
	var input = Vector2(
		Input.get_action_strength("game_right")-Input.get_action_strength("game_left"),
		Input.get_action_strength("game_forward")-Input.get_action_strength("game_backward")
	)
	dir = Vector3(input.x, 0, input.y).normalized()
	if dir.length() > 0:
		lastDir = dir
	
	aiming = Input.is_action_pressed("game_aim_lock")
	
	if !aiming:
		vel = Vector3(input.x, 0, input.y)*maxHSpd
	else:
		vel = vel - Vector3(vel.x, 0, vel.z)
	
	if is_on_floor() || is_on_ceiling():
		vel.y = 0
	else:
		vel.y -= 1
		vel.y = max(vel.y, maxVSpd)*sign(vel.y)
	
	var snap = Vector3.DOWN*10
	move_and_slide_with_snap(vel, snap, Vector3.UP, true)

func _process(delta):
	var mov = vel
	mov.y = 0
	
	moving = mov.length() > 0
	get_parent().distanceCovered += mov.length()/10
	
	if sign(dir.x) != lastInputDirH && dir.x != 0:
		lastInputDirH = sign(dir.x)
	
	if moving && !$Tween.is_active():
		lastSide = lastInputDirH*-1
		tweenSide()
	
	#Indicator
	if aiming && dir.length() > 0:
		#Rotation
		$ArrowOrigin.rotation.y = .5*PI - Vector2(dir.x, dir.z).angle()
		
		#Fade in
		if $ArrowOrigin/Arrow.modulate.a == 0:
			$ArrowOrigin/Arrow/VisibilityTween.interpolate_property($ArrowOrigin/Arrow, "modulate", $ArrowOrigin/Arrow.modulate, Color(1,1,1,1), .3, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			$ArrowOrigin/Arrow/VisibilityTween.start()
	#fade out
	elif $ArrowOrigin/Arrow.modulate.a == 1:
		$ArrowOrigin/Arrow/VisibilityTween.interpolate_property($ArrowOrigin/Arrow, "modulate", $ArrowOrigin/Arrow.modulate, Color(0,0,0,0), .3, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		$ArrowOrigin/Arrow/VisibilityTween.start()
	
	
	
	if aiming && $Timer.time_left <= 0:
		if Input.is_action_just_pressed("game_b"):
			shootProjectile(0)
		if Input.is_action_just_pressed("game_a"):
			shootProjectile(1)
		if Input.is_action_just_pressed("game_x"):
			shootProjectile(2)
		if Input.is_action_just_pressed("game_y"):
			shootProjectile(3)

func tweenSide():
	$Tween.interpolate_property($SpriteOrigin, "rotation_degrees", $SpriteOrigin.rotation_degrees, Vector3(-30, 0, lastSide*4), .5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween.start()

func shootProjectile(type):
	$Timer.start()
	
	var projectile = projectileScene.instance()
	
	projectile.dir = lastDir
	projectile.type = type
	projectile.translation = self.translation + Vector3(0, 1, 0)
	
	get_parent().add_child(projectile)
	

func _on_Tween_tween_completed(object, key):
	var mov = vel
	mov.y = 0
	if (moving):
		lastSide *= -1
		
		var stepA = preload("res://sounds/FootStepA.wav")
		var stepB = preload("res://sounds/FootStepB.wav")
		
		$FootSteps.stream = stepA if randf() < .5 else stepB
		$FootSteps.play()
		
		tweenSide()
	elif $SpriteOrigin.rotation_degrees != Vector3(-30, 0, 0):
		$Tween.interpolate_property($SpriteOrigin, "rotation_degrees", $SpriteOrigin.rotation_degrees, Vector3(-30, 0, 0), .1, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
		$Tween.start()

func setHP(val):
	if val < hp:
		$Audio.play()
		get_parent().get_node("UI/UIAnimations").play("hit")
	hp = max(val, 0)
	get_parent().get_node("UI/FullScreen/Margin/UIElementHPBar").setHP(hp)
	if hp <= 0:
		get_parent().get_node("UI/FullScreen/GameOverScreen").showScreen(get_parent().score)
