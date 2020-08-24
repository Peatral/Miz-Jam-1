extends Spatial


var veggies = [
	0,
	1,
	2,
	3,
	4,
	5,
	8,
	11,
	12
]
func _ready():
	randomize()
	$SpriteOrigin/Sprite.frame = veggies[int(randf()*veggies.size())]


func _on_Trigger_body_entered(body):
	randomize()
	$Tween.interpolate_property($SpriteOrigin, "rotation_degrees", $SpriteOrigin.rotation_degrees, Vector3(-30, 0, -4*sign(randf()-.5)),.4, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()


func _on_Tween_tween_completed(object, key):
	if $SpriteOrigin.rotation_degrees.z != 0:
		$Tween.interpolate_property($SpriteOrigin, "rotation_degrees", $SpriteOrigin.rotation_degrees, Vector3(-30, 0, 0), 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
		$Tween.start()
