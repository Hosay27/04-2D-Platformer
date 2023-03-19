extends Area2D


func _ready():
	pass


func _on_Portal_body_entered(body):
	if body.name == "Player":
		if name == "Portal":
			Global.health = 10
			Global.level = 2
			Global.damage += 2
			get_tree().change_scene("res://Levels/Level2.tscn")
		if name == "Portal2":
			Global.health = 10
			Global.level = 3
			Global.damage += 2
			get_tree().change_scene("res://Levels/Level3.tscn")
		if name == "Portal3":
			get_tree().change_scene("res://UI/End_Game.tscn")
