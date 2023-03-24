extends Area2D

export var score = 50

func _ready():
	pass


func _on_Coin_body_entered(body):
	if body.name == "Player":
		Global.increase_score(score)
		var collect = get_node_or_null("/root/Game/Coin_Sound")
		if collect != null:
			collect.play()
		queue_free()
