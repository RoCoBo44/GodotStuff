extends "res://KinematicBody2D.gd"

var mov = 0 
export var maxmov = 200
var bl = 0
export var maxbl = 100.0

func _ready():
	#$Sprite.modulate = Color(2 ,2, 2)
	$Sprite.modulate = Color(0 , 0.9, 0.4)
	label.set_text('0')
	pass
	
func _physics_process(delta):
	if auto and !stop:
		mov+=1
	if (mov == maxmov):
		mov = 0
		money+=1
		bl = 1
		print(money)
	if bl >= 1:
		bl+=1
		label.set_text(String(money))
		$Sprite.modulate = Color(1 - bl/maxbl , 0.9 + 1 - bl/maxbl, 0.4 + 1 - bl/maxbl)
		if bl == maxbl:
			bl = 0


func interaction(otroBot):
	return null

func get_character():
	return 1
	
	