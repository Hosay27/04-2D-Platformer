extends StaticBody2D
onready var Attack = load("res://Attacks/Cannonball.tscn")

export var direction = 1
export var spawn = Vector2(0,0)

func _ready():
	$Timer.start()

func _physics_process(_delta):
	if direction > 0:
		$Sprite.flip_h = false
	if direction < 0:
		$Sprite.flip_h = true

func _on_Timer_timeout():
	$Smoke.emitting = true
	var shoot = get_node_or_null("/root/Game/Hazards/Cannon/Shoot")
	if shoot != null:
		shoot.play()
	var attack = Attack.instance()
	attack.position = global_position
	attack.position += spawn
	#attack.direction = direction
	get_node("/root/Game/Attack_Container").add_child(attack)
	$Timer.start()
