extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var cantidadW = 4
export var cantidadL = 4
var radius = 240
var angle_step
onready var botW = preload("res://Body/Worker.tscn")
onready var botL = preload("res://Body/Ladron.tscn")
onready var botContainer = get_node("botsContainer")
var center 
var screen_size = OS.get_screen_size()
var window_size = OS.get_window_size()

func _ready():
	OS.set_window_position(screen_size*0.5 - window_size*0.5)
	center = window_size/2
	angle_step = 2.0*PI / (cantidadW + cantidadL)
	var angle = 0
	var tam = 4
	for i in range(cantidadL+cantidadW):
		var direction = Vector2(cos(angle), sin(angle))
		var node
		if i < cantidadW:
			node = botW.instance()
		elif i < cantidadW + cantidadL:
			node = botL.instance()
		node.set_name("boti-".format(i))
		node.scale = Vector2(tam,tam)
		node.position = center + direction * radius
		botContainer.add_child(node)
		angle += angle_step
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass