extends Area2D


func _ready():
	pass


func _on_Spikes_body_entered(body):
	if not body.is_in_group("enemy"):
		if body.has_method("hit"):
			body.hit(1)
