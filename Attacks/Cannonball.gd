extends Area2D

var direction = 1
var velocity = Vector2.ZERO
var speed = 0.3


func _ready():
	pass

func _physics_process(_delta):
	velocity.x += speed * direction
	position += velocity

func _on_Cannonball_body_entered(body):
	$Explosion.emitting = true
	if not body.is_in_group("enemy"):
		if body.has_method("hit"):
			body.hit(3)
		queue_free()
		$Explosion.emitting = true
