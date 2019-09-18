extends "res://body/bot.gd"
export var stealingRate = 0.3
export var gettingRate = 0.5
var stole = false
var blink = 0
var blinkMax = 100.0
var activeGuardian = false
var timerToInactive

func _ready():
	timerToInactive = Timer.new()
	timerToInactive.connect("timeout",self,"_on_timerToInactive_timeout")
	add_child(timerToInactive)
	$Sprite.modulate = Color(0,0,1)
	timerToInactive.start(20)

func _on_timerToInactive_timeout():
	timerToInactive.stop()
	activeGuardian = false
	var colorValue = $Sprite.modulate
	$Sprite.modulate = Color(colorValue[0],colorValue[1],colorValue[2],0.2)
	
	
func get_character():
	return 3

func interaction(otroBot):
	if otroBot.get_character() == 2 and otroBot.is_active():
		var newmoney = 15 + 7*level#int(otroBot.get_money()*stealingRate)
		if otroBot.get_money() > newmoney:
			money += newmoney
			otroBot.reduce_money(newmoney)
			var myMoney = ceil(newmoney*gettingRate)
			newmoney -= myMoney
			if (newmoney > 0):
				get_parent().get_parent()._giveGuardians(newmoney)
		else:
			money += otroBot.get_money()
			otroBot.reduce_money(newmoney)
		otroBot._damaged()
		label.set_text(String(money))
		stole = true
		activeGuardian = true
		timerToInactive.start(20)

func _physics_process(delta):
	if stole:
		$Sprite.modulate = Color(0,1 - blink/blinkMax,1 + 1 - blink/blinkMax)
		blink+=1
		if blink >= blinkMax:
			#print("blinked")
			stole = false
			blink = 0


func is_activeGuardian():
	return activeGuardian
	

func give_money(m):
	money += m
	label.set_text(String(money))