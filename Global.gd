extends Node

onready var pause_music = get_node_or_null("/root/Game/UI/Pause_Menu/Music")
onready var hud = get_node_or_null("/root/Game/UI/HUD")


var score = 0
var lives = 5
var damage = 2
var max_lives = 5
var health = 10
var max_health = 10
var level = 1

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	print(Global.level)

func _process(_delta):
	pass

func increase_score(s):
	score += s

func decrease_hp(h):
	#clamp(health, 0, max_health)
	health -= h
	
func update_damage(d):
	damage += d

func decrease_lives(l):
	lives -= l
	health = max_health
	if lives <= 0:
		get_tree().change_scene("res://UI/End_Game.tscn")

func reset():
	lives = 5
	health = 10
	score = 0
	level = 1
	damage = 2


func _unhandled_input(_event):
	if Input.is_action_pressed("menu"):
		var Pause_Menu = get_node_or_null("/root/Game/UI/Pause_Menu")
		if Pause_Menu == null:
			get_tree().quit()
		else:
			if Pause_Menu.visible:
				Pause_Menu.hide()
				#music.stop()
				get_tree().paused = false
			else:
				Pause_Menu.show()
				print(pause_music)
				#music.play()
				get_tree().paused = true
