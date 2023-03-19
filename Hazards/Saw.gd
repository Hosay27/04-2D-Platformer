extends Node2D


func _ready():
	pass

func _physics_process(_delta):
	rotation_degrees += 10
	$Sparks.emitting = true

func _on_Hitbox_body_entered(body):
	if not body.is_in_group("enemy"):
		if body.has_method("hit"):
			body.hit(1)
