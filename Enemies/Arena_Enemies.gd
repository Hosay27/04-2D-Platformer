extends Node2D

onready var Goblin = load("res://Enemies/Goblin.tscn")

export var gob_spawn = Vector2(0,0)

func _process(_delta):
	if not has_node("Goblin"):
		var goblin = Goblin.instance()
		goblin.position = gob_spawn
		goblin.name = "Goblin"
		add_child(goblin)
