extends KinematicBody2D

var locations = [
	position
	,Vector2(2345, -220)
	,Vector2(3245, -220)
]
export var duration = 3
var pos = 0

func _ready():
	$Timer.start()

func _on_Tween_tween_all_completed():
	pos = wrapf(pos+1, 0, locations.size())
	$Timer.start()

func _on_Timer_timeout():
	$Tween.interpolate_property(self, "position", locations[pos], locations[wrapf(pos+1, 0, locations.size())], duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
