extends KinematicBody2D

onready var effect = $AnimatedSprite/Effect

var player = null
onready var ray = $See
export var speed = 150
export var looking_speed = 70
var line_of_sight = false
var health = 3
var damage = 2

var mode = ""

var points = []
const margin = 1.5


func _ready():
	change_mode("move")

func _physics_process(_delta):
	var velocity = Vector2.ZERO
	player = get_node_or_null("/root/Game/Player_Container/Player")
	if player != null and mode != "die":
		ray.cast_to = ray.to_local(player.global_position)
		var c = ray.get_collider()
		line_of_sight = false
		if c and c.name == "Player":
			line_of_sight = true
		points = get_node_or_null("/root/Game/Navigation2D").get_simple_path(global_position, player.global_position, true)
		if points.size() > 1:
			var distance = points[1] - global_position
			var direction = distance.normalized()
			$AnimatedSprite.flip_h = false
			if direction.x < 0:
				$AnimatedSprite.flip_h = true
			if distance.length() > margin or points.size() > 2:
				if line_of_sight:
					velocity = direction * speed
				else:
					velocity = direction * looking_speed
	velocity = move_and_slide(velocity, Vector2.ZERO)

func change_mode(m):
	if mode != m and mode != "die":
		mode = m
		$AnimatedSprite.play(mode)

func hit(d):
	effect.play("Hurt")
	health -= d
	if health <= 0:
		change_mode("die")
		Global.increase_score(100)


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		hit(2)


func _on_Attack_body_entered(_body):
	if mode != "attack":
		change_mode("attack")
		$Attack/Timer.start()


func _on_Timer_timeout():
	if mode == "attack":
		var bodies = $Attack.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player":
				body.hit(damage)
			change_mode("move")


func _on_AnimatedSprite_animation_finished():
	if mode == "die":
		queue_free()
