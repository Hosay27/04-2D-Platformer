extends KinematicBody2D

onready var SM = $StateMachine
onready var inv_time = $Invincible
onready var effects = $AnimatedSprite/Effects
onready var Attack = load("res://Attacks/Fire.tscn")

var velocity = Vector2.ZERO
var jump_power = Vector2.ZERO
var direction = 1


export var gravity = Vector2(0, 1)

export var move_speed = 60
export var max_move = 300

export var jump_speed = 230
export var max_jump = 950

export var leap_speed = 150
export var max_leap = 1800

export var time_a = 1
#var damage = 2

var moving = false
var is_jumping = false
var double_jumped = false
var should_direction_flip = true # whether or not player controls (left/right) can flip the player sprite
var is_on_moving_platform = false

func _ready():
	pass

func _physics_process(_delta):
	velocity.x = clamp(velocity.x,-max_move,max_move)
	#print(Global.damage)
	if should_direction_flip:
		if direction < 0 and not $AnimatedSprite.flip_h: 
			$AnimatedSprite.flip_h = true


		if direction > 0 and $AnimatedSprite.flip_h:
			$AnimatedSprite.flip_h = false

	
	if is_on_floor():
		double_jumped = false
		if Input.is_action_just_pressed("attack"):
			SM.set_state("Attack")

	#if is_on_moving_platform == true:
		#set_sync_to_physics(true)
	#else:
		#set_sync_to_physics(false)

func is_moving():
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		return true
	return false

func move_vector():
	return Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"),1.0)

func _unhandled_input(event):
	if event.is_action_pressed("left"):
		direction = -1

	if event.is_action_pressed("right"):
		direction = 1


func set_animation(anim):
	if $AnimatedSprite.animation == anim: return
	if $AnimatedSprite.frames.has_animation(anim): $AnimatedSprite.play(anim)
	else: $AnimatedSprite.play()

func is_on_floor():
	is_on_moving_platform = false
	var fl = $Floor.get_children()
	for f in fl:
		if f.is_colliding():
			var c = f.get_collider()
			if c.get_parent().name == "Platform_Container":
				is_on_moving_platform = true
			return true
	return false

func attack():
	var attack = Attack.instance()
	attack.position = global_position
	attack.position.x += 40*direction
	attack.direction = direction
	get_node("/root/Game/Attack_Container").add_child(attack)


func hit(d):
	if inv_time.is_stopped():
		inv_time.start()
		Global.decrease_hp(d)
		effects.play("Hurt")
		effects.queue("Flash")
		if Global.health <= 0:
			die()

func die():
	Global.decrease_lives(1)
	SM.set_state("Die")

func _on_Invincible_timeout():
	effects.play("Normal")

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Attack":
		SM.set_state("Idle")
	if $AnimatedSprite.animation == "Die":
		queue_free()
