extends Area2D

var direction = 1
var velocity = Vector2.ZERO
var speed = 0.4

func _ready():
	pass

func _physics_process(_delta):
	if direction < 0 and !$AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = true
	velocity.x += speed * direction
	position += velocity

func _on_Fire_body_entered(body):
	if body.is_in_group("enemy"):
		if body.has_method("hit"):
			body.hit(Global.damage)
		queue_free()
	elif body.name != "Player":
		queue_free()
