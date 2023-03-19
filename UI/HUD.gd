extends Control

onready var hp_bar = $HealthBar
onready var healthy = $Full
onready var low = $Low
onready var tween = $Tween

func update_score():
	$Score.text = "Score: " + str(Global.score)

func update_health():
	#print(Global.health)
	hp_bar.value = int(Global.health)
	#tween.interpolate_property(hp_bar, "value", hp_bar.value, int(Global.health), 0.4, Tween.TRANS_SINE, Tween.EASE_OUT)
	#tween.start()
	if hp_bar.value > 7:
		hp_bar.tint_progress = Color8(0,255,2)
		healthy.show()
		low.hide()
	elif hp_bar.value <= 7 and hp_bar.value > 4:
		hp_bar.tint_progress = Color8(255,255,0)
		healthy.hide()
		low.show()
	elif hp_bar.value <= 4:
		hp_bar.tint_progress = Color8(255,0,0)

func update_lives():
	$Lives.text = "x" + str(Global.lives)
	if Global.lives >= 2:
		$Heart.set_animation("Normal")
	else:
		$Heart.set_animation("Low")
		

func _physics_process(_delta):
	update_score()
	update_health()
	update_lives()
