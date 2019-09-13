extends KinematicBody2D
export (int) var speed = 200

var velocity = Vector2()
var auto = false
var movimientos = []
var movActual = 0
export var movMaximo = 80
var stop = false

func get_input():
	
	if Input.is_key_pressed(KEY_K):
		auto = !auto
	
	if (!auto):
	    velocity = Vector2()
	    if Input.is_action_pressed('ui_right'):
	        velocity.x += 1
	    if Input.is_action_pressed('ui_left'):
	        velocity.x -= 1
	    if Input.is_action_pressed('ui_down'):
	        velocity.y += 1
	    if Input.is_action_pressed('ui_up'):
	        velocity.y -= 1
	else:
		velocity = Vector2()
		velocity.x = movimientos[movActual]
		velocity.y = movimientos[movActual+1]
		movActual = movActual+2
		if (movActual >= movMaximo):
			movActual=0
		
	velocity = velocity.normalized() * speed
func _ready():
	_cargar_movimientos()
	
func _cargar_movimientos():
	
	for i in range(0,movMaximo):
		movimientos.append(rand_range(-1,1))

func _physics_process(delta):
	
	get_input()
	if not stop:
		velocity = move_and_slide(velocity)



func _on_Base_body_exited(body):
	stop = true
