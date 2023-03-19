extends Node

onready var SM = get_parent()
onready var player = get_node("../..")

func _ready():
	yield(player, "ready")

func start():
	player.set_animation("Attack")
	player.get_node("Sword").offset.y = 5
	player.get_node("Sword").offset.x = 0
	var slash = get_node_or_null("/root/Game/Player_Container/Player/Slash")
	#print(jump)
	if slash != null:
		slash.play()
	$Timer.start()

func end():
	player.get_node("Sword").offset.y = 0
	player.get_node("Sword").offset.x = 0

func physics_process(_delta):
	pass


func _on_Timer_timeout():
	if SM.state_name == "Attack":
		player.attack()
