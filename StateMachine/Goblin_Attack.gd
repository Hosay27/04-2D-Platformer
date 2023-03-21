extends Node

onready var SM = get_parent()
onready var enemy = get_node("../..")

func _ready():
	yield(enemy, "ready")
	#print("attack")

func start():
	enemy.velocity = Vector2.ZERO
	$Attack.start()
	enemy.set_animation("Attack")

func physics_process(_delta):
	pass


func _on_Attack_timeout():
	if SM.state_name == "Attack":
		enemy.attack_target()
