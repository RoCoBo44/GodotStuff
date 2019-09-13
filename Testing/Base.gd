extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
export var cantidad = 9
var radius = 9
var angle_step = 2.0*PI / cantidad

func _ready():
	var angle = 0
	var tam = 0.2
	for i in range(0,cantidad):
		var center = position
		var direction = Vector2(cos(angle), sin(angle))
		var node = load("res://Body/Bot.tscn").instance()
		node.set_name("boti{0}".format(i))
		node.scale = Vector2(tam,tam)
		node.position = node.position + direction * radius
		add_child(node)
		angle += angle_step
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
