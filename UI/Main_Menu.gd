extends Control


func _ready():
	var music = get_node_or_null("/root/Main_Menu/Music")
	if music != null:
		music.play()

func _on_Play_pressed():
	get_tree().change_scene("res://Levels/Level1.tscn")

func _on_Quit_pressed():
	get_tree().quit()
