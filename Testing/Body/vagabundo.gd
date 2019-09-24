extends "res://Body/bot.gd"

var BaseChance = 0.0005
var weightBase = 1
var weigntPorsUser = 0.2
var weightPorsVag = 0.2

func _ready():
	$Sprite.modulate = Color(1,0.4,0)
	money = 0
	label.set_text(String(money))
	
	pass # Replace with function body.

func interaction(otroBot):
	if otroBot.is_active() and otroBot.get_character() != 0:
		
		var m = otroBot._giveSome()
		if m > 0:
			otroBot._damaged()
			##hacer que le den en una prob todo lo que tiene 
			var porsUser = m/otroBot.get_money()
			var porsVag = 1
			if money > 0:
				porsVag = m/money
			var auxScale = scale
			if (randf() < (BaseChance * weightBase + porsUser * weigntPorsUser + porsVag * weightPorsVag)/(weightPorsVag +weigntPorsUser + weightBase)):
			#if true:
				var moneyToAward = int(rand_range(1 + 20 *porsUser + 20 * porsVag ,money)) #change min value
				if moneyToAward > money:
					moneyToAward = money
				money -= moneyToAward
				otroBot.receive_money(moneyToAward)
				animate(Color(2, 0.8, 0))
			else:
				animate(Color(1, 0.7, 0.4))
				money+=m
				otroBot.reduce_money(m)
			label.set_text(String(money))
			scale = auxScale

func animate(c):
	var auxScale = scale
	$Tween.interpolate_property(self, "scale", auxScale, Vector2(5,5), 0.2, Tween.TRANS_BOUNCE  , Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	$Tween.interpolate_property($Sprite, "modulate", Color(1,0.4,0), c, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	yield($Tween, "tween_completed")
	$Tween.interpolate_property(self, "scale", Vector2(5,5), auxScale , 0.2, Tween.TRANS_BOUNCE  , Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	$Tween.interpolate_property($Sprite, "modulate", c,  Color(1 , 0.4 , 0), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	yield($Tween, "tween_completed")
	$Sprite.modulate = Color(1,0.4,0)
	scale = auxScale
