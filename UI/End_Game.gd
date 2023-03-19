extends Control


func _ready():
	$Label.text = "Thanks for playing! Your score was " + str(Global.score) + "."


func _on_Main_Menu_pressed():
	Global.reset()
	get_tree().change_scene("res://UI/Main_Menu.tscn")


func _on_Quit_pressed():
	get_tree().quit()
