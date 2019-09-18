extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var moneyToLevel = 10
var distribution = 20
onready var tween = $Tween
onready var sp = $Sprite
var auxScale = scale
var maxprecio
# Called when the node enters the scene tree for the first time.
func _ready():
	var s = String(formula(0)) + '\n' +  String(formula(1)) + '\n' +  String(formula(2)) + '\n'  +  String(formula(3)) + '\n' 
	maxprecio = formula(0)
	$Label.set_text(String(s))
	pass # Replace with function body.

func can_levelUp(money,level):
	if money > formula(level): ##tendria que cambiar a una funcion curva 
		return true
	return false

func moneyToLevelUp(level):
	animate()
	if maxprecio < formula(level):

		maxprecio = formula(level)
		#$Label.set_text(String(maxprecio))
	return formula(level) #la formula da cuakquiera
	
func formula(level):
	return round((pow(moneyToLevel* (level+1),2.5)/distribution) )
func animate():
	##ACA PASA ALGO RARO QUE NO SE ACTIVA
	tween.interpolate_property(self, "scale", auxScale, Vector2(2,2), 0.4, Tween.TRANS_ELASTIC  , Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")
	tween.interpolate_property(self, "scale", Vector2(2,2), auxScale, 0.4, Tween.TRANS_ELASTIC  , Tween.EASE_IN_OUT)
	tween.start()
	yield(tween, "tween_completed")
	scale = auxScale
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	animate()
