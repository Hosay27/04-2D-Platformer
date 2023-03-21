extends Node2D

onready var Goblin = load("res://Enemies/Goblin.tscn")
onready var Slime = load("res://Enemies/Slime.tscn")

export var gob_spawn = Vector2(0,0)
export var slime_spawn = Vector2(0,0)

func _process(_delta):
	if not has_node("Goblin"):
		var goblin = Goblin.instance()
		#print(goblin)
		goblin.position = gob_spawn
		goblin.name = "Goblin"
		add_child(goblin)
	if not has_node("Slime"):
		var slime = Slime.instance()
		#print(slime)
		slime.position = slime_spawn
		slime.name = "Slime"
		add_child(slime)
