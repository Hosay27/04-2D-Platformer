extends Area2D

var direction = 1
var velocity = Vector2.ZERO
var speed = .2


func _physics_process(_delta):
	if direction < 0 and !$Sprite.flip_h:
		$Sprite.flip_h = true
	rotation_degrees += 15
	velocity.x += speed * direction
	position += velocity

func _on_Bone_body_entered(body):
	if not body.is_in_group("enemy"):
		if body.has_method("hit"):
			body.hit(1)
		queue_free()
