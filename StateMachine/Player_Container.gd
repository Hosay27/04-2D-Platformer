extends Node2D

onready var Player = load("res://Player/Player.tscn")
export var initial_position = Vector2(0,0)

func _process(_delta):
	if not has_node("Player"):
		var player = Player.instance()
		player.position = initial_position
		player.name = "Player"
		add_child(player)
