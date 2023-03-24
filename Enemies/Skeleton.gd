extends KinematicBody2D

onready var SM = $StateMachine
onready var effects = $AnimatedSprite/Effect
onready var Attack = load("res://Attacks/Bone.tscn")

export var walking = 200
export var running = 1000
export var path = [Vector2(0,0), Vector2(0,0)]
export var health = 6
var velocity = Vector2.ZERO
export var direction = 1
export var score = 250

func _ready():
	position = path[0]
	velocity.x = walking
	SM.set_state("Move")

func _physics_process(_delta):
	velocity = move_and_slide(velocity, Vector2.ZERO)
	#print(health)
	if velocity.x < 0 and not $AnimatedSprite.flip_h: 
		$AnimatedSprite.flip_h = true
		direction = -1
		$Sight.cast_to.x = -1*abs($Sight.cast_to.x)
	if velocity.x > 0 and $AnimatedSprite.flip_h: 
		$AnimatedSprite.flip_h = false
		direction = 1
		$Sight.cast_to.x = abs($Sight.cast_to.x)

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


func should_attack():
	if $Sight.is_colliding() and $Sight.get_collider().name == "Player":
		return true
	return false

func attack_target():
	print("attack")
	var attack = Attack.instance()
	attack.position = global_position
	attack.position.x += 50*direction
	attack.direction = direction
	get_node("/root/Game/Attack_Container").add_child(attack)
	var shoot = get_node_or_null("/root/Game/Shoot")
	if shoot != null:
		shoot.play()
	
func _on_AnimatedSprite_animation_finished():
	if SM.state_name == "Attack":
		SM.set_state("Move")
	if SM.state_name == "Die":
		#print("dead")
		queue_free()


func _on_Above_and_Below_body_entered(body):
	if body.name == "Player":
		hit(100)
