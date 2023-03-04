extends Camera2D

var player = get_node_or_null("/root/Game/Player_Container/Player")

func _process(_delta):
	if player == null:
		player = get_node_or_null("/root/Game/Player_Container/Player")
	else:
		position = player.position
