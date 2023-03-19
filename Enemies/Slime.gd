extends KinematicBody2D

onready var SM = $StateMachine
onready var effects = $AnimatedSprite/Effects

export var walking = 100
export var running = 100
export var path = [Vector2(450,230), Vector2(1020,230)]
var velocity = Vector2.ZERO
export var direction = 1
export var score = 20
export var damage = 1
export var health = 2

func _ready():
	position = path[0]
	velocity.x = walking
	SM.set_state("Move")

func _physics_process(_delta):
	velocity = move_and_slide(velocity, Vector2.ZERO)
	
	if velocity.x < 0 and not $AnimatedSprite.flip_h: 
		$AnimatedSprite.flip_h = true
		direction = -1
	if velocity.x > 0 and $AnimatedSprite.flip_h: 
		$AnimatedSprite.flip_h = false
		direction = 1
	
func set_animation(anim):
	if $AnimatedSprite.animation == anim: return
	if $AnimatedSprite.frames.has_animation(anim): $AnimatedSprite.play(anim)
	else: $AnimatedSprite.play()

func hit(d):
	health -= d
	effects.play("Hurt")
	if health <= 0:
		Global.increase_score(score)
		SM.set_state("Die")

func _on_Above_and_Below_body_entered(body):
	if body.name == "Player" and SM.state_name != "Die":
		collision_layer = 0
		collision_mask = 0
		body.hit(damage)
		hit(2)


func _on_AnimatedSprite_animation_finished():
	if SM.state_name == "Die":
		queue_free()
