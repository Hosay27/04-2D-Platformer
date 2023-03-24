extends Area2D

var direction = 1
var velocity = Vector2.ZERO
var speed = 0.2

func _ready():
	pass

func _physics_process(_delta):
	velocity.y -= speed
	position += velocity

func _on_Icicle_body_entered(body):
	if body.is_in_group("enemy"):
		if body.has_method("hit"):
			body.hit(Global.damage)
		queue_free()
	elif body.name != "Player":
		queue_free()
