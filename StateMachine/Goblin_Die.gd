extends Node

onready var SM = get_parent()
onready var enemy = get_node("../..")

func _ready():
	yield(enemy, "ready")

func start():
	enemy.set_animation("Die")
	enemy.velocity = Vector2.ZERO
	enemy.collision_layer = 0
	enemy.collision_mask = 0
	var dead = get_node_or_null("/root/Game/Gob_Dead")
	#print(dead)
	if dead != null:
		dead.play()
