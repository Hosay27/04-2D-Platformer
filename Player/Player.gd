extends KinematicBody2D

onready var SM = $StateMachine
onready var inv_time = $Invincible
onready var effects = $Sword/Effects

var velocity = Vector2.ZERO
var jump_power = Vector2.ZERO
var direction = 1

export var gravity = Vector2(0, 30)

export var move_speed = 60
export var max_move = 300

export var jump_speed = 250
export var max_jump = 1300

export var leap_speed = 150
export var max_leap = 1700

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
		if direction < 0 and not $Sword.flip_h: 
			$Sword.flip_h = true
			$Top.cast_to.x = -1 * abs($Top.cast_to.x)
			$Middle.cast_to.x = -1 * abs($Middle.cast_to.x)
			$Bottom.cast_to.x = -1 * abs($Bottom.cast_to.x)
			
		if direction > 0 and $Sword.flip_h:
			$Sword.flip_h = false
			$Top.cast_to.x = abs($Top.cast_to.x)
			$Middle.cast_to.x = abs($Middle.cast_to.x)
			$Bottom.cast_to.x = abs($Bottom.cast_to.x)
	
	if is_on_floor():
		double_jumped = false
		if Input.is_action_just_pressed("attack"):
			SM.set_state("Attack")
			if direction == 1:
				$Sword.offset.x = 10
			else:
				$Sword.offset.x = -31
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
		$Sword.offset.x = -20
	if event.is_action_pressed("right"):
		direction = 1
		$Sword.offset.x = 0

func set_animation(anim):
	if $Sword.animation == anim: return
	if $Sword.frames.has_animation(anim): $Sword.play(anim)
	else: $Sword.play()

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
	if $Top.is_colliding():
		var target = $Top.get_collider()
		#print(target)
		if target.has_method("hit"):
			target.hit(Global.damage)

	if $Middle.is_colliding():
		var target = $Middle.get_collider()
		#print(target)
		if target.has_method("hit"):
			target.hit(Global.damage)
	if $Bottom.is_colliding():
		var target = $Bottom.get_collider()
		#print(target)
		if target.has_method("hit"):
			target.hit(Global.damage)


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


func _on_Sword_animation_finished():
	if $Sword.animation == "Attack":
		SM.set_state("Idle")
		if direction == 1:
			$Sword.offset.x = 0
		else:
			$Sword.offset.x = -20
	if $Sword.animation == "Die":
		queue_free()


func _on_Invincible_timeout():
	effects.play("Normal")


func _on_Health_timeout():
	Global.decrease_hp(-Global.level)
