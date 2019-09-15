extends "res://body/bot.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var stealingRate = 0.3
var stole = false
var blink = 0
var blinkMax = 100.0
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.modulate = Color(1,0,0)

func interaction(otroBot):
	if otroBot.get_character() == 1 and otroBot.is_active():
		var newmoney = int(otroBot.get_money()* stealingRate)
		otroBot._damaged()
		otroBot.reduce_money(newmoney)
		money += newmoney
		label.set_text(String(money))
		stole = true

func _physics_process(delta):
	if stole:
		$Sprite.modulate = Color(1 + 1 - blink/blinkMax,1 - blink/blinkMax,0)
		blink+=1
		if blink >= blinkMax:
			stole = false
			blink = 0

func get_character():
	return 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
