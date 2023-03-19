extends Area2D

var direction = 1
var velocity = Vector2.ZERO
var speed = .8


func _physics_process(_delta):
	if direction < 0 and !$Sprite.flip_h:
		$Sprite.flip_h = true
	velocity.x += speed * direction
	position += velocity

func _on_Enemy_Arrow_body_entered(body):
	if not body.is_in_group("enemy"):
		if body.has_method("hit"):
			body.hit(2)
		queue_free()
