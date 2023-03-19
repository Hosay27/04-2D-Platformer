extends Control

func _on_Quit_pressed():
	get_tree().quit()


func _on_Restart_pressed():
	get_tree().paused = false
	Global.reset()
	var _scene = get_tree().change_scene("res://Levels/Level1.tscn")


func _on_Main_Menu_pressed():
	Global.reset()
	get_tree().change_scene("res://UI/Main_Menu.tscn")
	get_tree().paused = false
