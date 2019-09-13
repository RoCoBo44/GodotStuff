extends KinematicBody2D
export (int) var speed = 100

var maxIda 
var velocity = Vector2()
var auto = false
var movimientos = []
var movActual = 0
export var movMaximo = 80
var stop = false
var ida 

func get_input():
	velocity = Vector2()	

	if Input.is_key_pressed(KEY_K):
		auto = !auto
	
	if (!auto):
	    if Input.is_action_pressed('ui_right'):
	        velocity.x += 1
	    if Input.is_action_pressed('ui_left'):
	        velocity.x -= 1
	    if Input.is_action_pressed('ui_down'):
	        velocity.y += 1
	    if Input.is_action_pressed('ui_up'):
	        velocity.y -= 1
	else:
		if (ida > 0):
			ida-=1
			velocity.x = movimientos[movActual]
			velocity.y = movimientos[movActual+1]
			if ida == 0:
				ida = maxIda
				movActual = movActual+2
				if (movActual >= movMaximo):
					movActual=0
		
	velocity = velocity.normalized() * speed
func _ready():
	randomize()
	_cargar_movimientos()
	maxIda = int(rand_range(50,200))
	ida = maxIda
	
func _cargar_movimientos():
	for i in range(0,movMaximo):
		movimientos.append(rand_range(-1,1))

func _physics_process(delta):
	get_input()
	if not stop:
		velocity = move_and_slide(velocity)

func _on_Area2D_area_exited(area):
	if area.get_name() == 'Base':
		stop = true
		print('bye' + area.get_name())
