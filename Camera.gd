extends Camera2D

func _process(_delta):
	var target = get_node_or_null("/root/Game/Player_Container/Player")
	if target != null:
		position = target.position
