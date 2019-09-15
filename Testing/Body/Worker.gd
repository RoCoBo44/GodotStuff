extends "res://body/bot.gd"

var mov = 0 
export var maxmov = 200
var bl = 0
export var maxbl = 100.0
var monInc = 0.2

func _ready():
	#$Sprite.modulate = Color(2 ,2, 2)
	$Sprite.modulate = Color(0 , 0.9, 0.4)
	label.set_text('0')
	pass
	
func _physics_process(delta):
	if auto and !stop and active:
		mov+=1

	if (mov >= maxmov) and active:
		mov = 0
		money = money + 10 + int(money*monInc) #parche para hacer sentir que tener plata en mano tambien esta bueno
		bl = 1
		#print(money)
	if bl >= 1:
		bl+=1
		label.set_text(String(money))
		$Sprite.modulate = Color(4 - bl/maxbl*4 , 0.9 + (1 - bl/maxbl)*3, 0.4 + 1 - bl/maxbl)
		if bl == maxbl:
			bl = 0


func get_character():
	return 1
	
	