extends "res://KinematicBody2D.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var stealingRate = 0.3
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.modulate = Color(1,0,0)

func interaction(otroBot):
	if otroBot.get_character() == 1:
		var newmoney = int(otroBot.get_money()* stealingRate)
		otroBot._damaged()
		otroBot.reduce_money(newmoney)
		money += newmoney


func get_character():
	return 2
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
