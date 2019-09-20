extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var cantidadW = 4
export var cantidadL = 4
export var cantidadG = 4
export var cantidadV = 1
var radius = 240
var angle_step
onready var botW = preload("res://Body/Worker.tscn")
onready var botL = preload("res://Body/Ladron.tscn")
onready var botG = preload("res://Body/Guardian.tscn")
onready var botV = preload("res://Body/vagabundo.tscn")
onready var botContainer = get_node("botsContainer")
var center
var screen_size = OS.get_screen_size()
var window_size = OS.get_window_size()


onready var ProW = get_node("Progress Worker")
onready var ProL = get_node("Progress Ladron")
onready var ProG = get_node("Progress Guardian")

onready var shop = preload("res://Shop.tscn")
onready var shopsContainer = get_node("Shops")

var timer


func _ready():
	randomize()
	OS.set_window_position(screen_size*0.5 - window_size*0.5)
	center = window_size/2
	angle_step = 2.0*PI / (cantidadW + cantidadL + cantidadG + cantidadV)
	var angle = 0
	var tam = 4
	for i in range(cantidadL+cantidadW + cantidadG + cantidadV):
		var direction = Vector2(cos(angle), sin(angle))
		var node
		if i < cantidadW:
			node = botW.instance()
		elif i < cantidadW + cantidadL:
			node = botL.instance()
		elif i < cantidadW + cantidadL + cantidadG:
			node = botG.instance()
		elif i < cantidadW + cantidadL + cantidadG + cantidadV:
			node = botV.instance()
		node.set_name("boti-".format(i))
		node.scale = Vector2(tam,tam)
		node.position = center + direction * radius
		botContainer.add_child(node)
		angle += angle_step
	
	var direction = Vector2(cos(rand_range(0,360)), sin(rand_range(0,360)))
	var node = shop.instance()
	node.position = center + direction * rand_range(0,100)
	shopsContainer.add_child(node)
	
	timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout")
	add_child(timer)
	timer.start(1)

func _giveGuardians(m):
	for i in range(botContainer.get_child_count()):
		var node = botContainer.get_child(i)
		
		if node.get_character() == 3 and node.is_activeGuardian():
			node.receive_money(ceil(m/cantidadG))

func _on_timer_timeout():
	
	### ESTE CODIGO ES UNA MIERDA tengo que abs
	
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
	var total =  MW+ML+MG

	ProW._actualize(total,MW,cantidadW)
	ProL._actualize(total,ML,cantidadL)
	ProG._actualize(total,MG,cantidadG)

	timer.start(1)



