extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var cantidadW = 4
export var cantidadL = 4
export var cantidadG = 4
var radius = 240
var angle_step
onready var botW = preload("res://Body/Worker.tscn")
onready var botL = preload("res://Body/Ladron.tscn")
onready var botG = preload("res://Body/Guardian.tscn")
onready var botContainer = get_node("botsContainer")
var center
var screen_size = OS.get_screen_size()
var window_size = OS.get_window_size()

##Para el Contador de como van 
onready var labelW = get_node("Worker")
onready var labelL = get_node("Ladron")
onready var labelG = get_node("Guardian")
var timer


func _ready():
	OS.set_window_position(screen_size*0.5 - window_size*0.5)
	center = window_size/2
	angle_step = 2.0*PI / (cantidadW + cantidadL + cantidadG)
	var angle = 0
	var tam = 4
	for i in range(cantidadL+cantidadW + cantidadG):
		var direction = Vector2(cos(angle), sin(angle))
		var node
		if i < cantidadW:
			node = botW.instance()
		elif i < cantidadW + cantidadL:
			node = botL.instance()
		elif i < cantidadW + cantidadL + cantidadG:
			node = botG.instance()
		node.set_name("boti-".format(i))
		node.scale = Vector2(tam,tam)
		node.position = center + direction * radius
		botContainer.add_child(node)
		angle += angle_step
	
	timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout")
	add_child(timer)
	timer.start(1)

func _giveGuardians(m):
	for i in range(botContainer.get_child_count()):
		var node = botContainer.get_child(i)
		
		if node.get_character() == 3 and node.is_activeGuardian():
			node.give_money(ceil(m/cantidadG))

func _on_timer_timeout():
	var MW = 0.0
	var ML = 0.0
	var MG = 0.0
	
	for i in range(botContainer.get_child_count()):
		var node = botContainer.get_child(i)
		if node.get_character() == 1:
			MW += node.get_money()
		elif node.get_character() == 2:
			ML += node.get_money()
		elif node.get_character() == 3:
			MG += node.get_money()

	if (cantidadW > 0):
		labelW.set_text(str(MW/cantidadW))
	if (cantidadL > 0):
		labelL.set_text(str(ML/cantidadL))
	if (cantidadG > 0):
		labelG.set_text(str(MG/cantidadG))
	timer.start(1)



