extends Control


func _ready():
	pass


func _on_Play_pressed():
	get_tree().change_scene("res://Levels/Level1.tscn")

func _on_Bonus_pressed():
	Global.lives -= 2
	Global.level = 5
	get_tree().change_scene("res://Levels/Arena1.tscn")

func _on_Quit_pressed():
	get_tree().quit()
