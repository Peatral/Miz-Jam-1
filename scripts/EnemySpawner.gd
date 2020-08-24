extends Node


var enemyScene = preload("res://scenes/Enemy.tscn")

onready var player = get_parent().get_node("Player")
onready var ray = player.get_node("Ray")

var timerTime = 3

func _ready():
	$Timer.wait_time = 3
	$Timer.start()

func onTimeout():
	var enemyDir = randomDir()*20
	
	ray.cast_to = enemyDir
	ray.force_raycast_update()
	
	if !ray.is_colliding():
		print("spawning new enemy")
		call_deferred("spawnEnemy", player.translation + enemyDir)
	
	timerTime = 1+get_parent().distanceCovered*.04
	if get_parent().maximumDistance <= 0:
		timerTime = .6
	
	$Timer.wait_time = timerTime
	$Timer.start()

func randomDir():
	#randomize()
	return Vector3(randf()-.5, 0, randf()-.5).normalized()

func spawnEnemy(pos):
	var enemy = enemyScene.instance()
	enemy.translation = pos
	enemy.player = player
	get_parent().add_child(enemy)
