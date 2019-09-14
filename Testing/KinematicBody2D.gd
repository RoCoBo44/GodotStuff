extends KinematicBody2D
export (int) var speed = 100

var maxIda 
var velocity = Vector2()
var auto = false
var movimientos = []
var movActual = 0
export var movMaximo = 10
var stop = false
var ida 

var timer


func get_input():
	
	if not stop:
		velocity = Vector2()	
		
		#Change to auto
		if Input.is_key_pressed(KEY_K):
			auto = !auto
		
		#Directions MAnual
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
			#ida is used to slide to a direction
			if (ida > 0):
				ida-=1
				velocity.x = movimientos[movActual]
				velocity.y = movimientos[movActual+1]
				#print(movimientos[movActual]," ",movimientos[movActual+1])
				if ida == 0: #so we change direction
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
	
	timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout")
	add_child(timer) 

func _on_timer_timeout():
	#print('time')
	timer.stop()
	_reProcess()
	
func _reProcess():

	movimientos[movActual] *= -1
	movimientos[movActual+1] *= -1
	ida = int(rand_range(10,40))
	stop = false

func _cargar_movimientos():
	for i in range(0,movMaximo):
		movimientos.append(rand_range(-1,1))

func _physics_process(delta):
	if not stop:
		get_input()
		velocity = move_and_slide(velocity)

func _on_Area2D_area_exited(area):
	if area.get_name() == 'Base':
		stop = true
		timer.set_wait_time( 2 )
		timer.start()
		#print('wall')
	else:
		print("hey bro,wsa")
