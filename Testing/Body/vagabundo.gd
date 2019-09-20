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
			if (randf() < (BaseChance * weightBase + porsUser * weigntPorsUser + porsVag * weightPorsVag)/(weightPorsVag +weigntPorsUser + weightBase)):
				otroBot.receive_money(int(rand_range(1 ,money)))#change min value
			else:
				money+=m
				otroBot.reduce_money(m)
			label.set_text(String(money))

