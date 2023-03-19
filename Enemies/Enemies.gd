extends Node2D

onready var Bat = load("res://Enemies/Bat.tscn")

export var bat_spawn = Vector2(0,0)

func _process(_delta):
	if Global.level == 2:
		if not has_node("Bat"):
			var bat = Bat.instance()
			bat.position = bat_spawn
			bat.name = "Bat"
			add_child(bat)
