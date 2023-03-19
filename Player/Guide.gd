extends KinematicBody2D

var direction = 1
var velocity = Vector2.ZERO

func _process(_delta):
	var target = get_node_or_null("/root/Game/Player_Container/Player")
	if target != null:
		position = target.position - Vector2(0,60)

func _physics_process(_delta):
	$Light2D/Bounce.play("Bounce")
	$Sprite/Bounce.play("Bounce")
	if direction < 0 and not $Sprite.flip_h: 
		$Sprite.flip_h = true

	if direction > 0 and $Sprite.flip_h:
		$Sprite.flip_h = false



func _unhandled_input(event):
	if event.is_action_pressed("left"):
		direction = -1
	if event.is_action_pressed("right"):
		direction = 1
