extends KinematicBody2D
export (int) var speed = 100
onready var label = get_node("Label")

var maxIda
var velocity = Vector2()
var auto = true
var movimientos = []
var movActual = 0
export var movMaximo = 10
var stop = false
var ida
var money = 0
var timer
var timDamaged
var active = true


func get_input():

	 #change to Auto
	if Input.is_action_pressed('ui_accept'):
		auto = !auto
	if !auto:
		_manual()

func _automatic():
		velocity = Vector2()
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

func _manual():

	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _ready():
	randomize()
	_cargar_movimientos()
	maxIda = int(rand_range(50,200))
	ida = maxIda
	label.set_text('0')

	timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout")
	add_child(timer)
	timDamaged = Timer.new()
	timDamaged.connect("timeout",self,"_on_timDamage_timeout")
	add_child(timDamaged)

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
		if auto:
			_automatic()
		velocity = move_and_slide(velocity)

func _on_Area2D_area_exited(area):
	if area.get_name() == 'Base':
		stop = true
		timer.set_wait_time( 2 )
		timer.start()
		#print('wall')


func is_active():
	return active


func interaction(otroBot):
	return null

func get_stop():
	return stop

func _damaged():
	timer.set_wait_time( 500 )#timepo de espera para que pueda recuperarse
	timDamaged.start()
	active = false
	scale = Vector2(2,2)
	var colorValue = $Sprite.modulate
	$Sprite.modulate = Color(colorValue[0],colorValue[1],colorValue[2],0.2)

func _on_timDamage_timeout():
	timDamaged.stop()
	active = true
	scale = Vector2(4,4)
	var colorValue = $Sprite.modulate
	$Sprite.modulate = Color(colorValue[0],colorValue[1],colorValue[2],0.7)

func get_character():
	return 0

func get_money():
	return money

func reduce_money(value):
	if (money-value > 0):
		money-=value
	else:
		money = 0
	label.set_text(String(money))

func _on_Area2D_area_entered(area):

	if (area.get_name() == 'Area2D' and (area.get_parent().get_stop() == false and area.get_parent().is_active() == true and active == true and stop == false)):

		#print("this ",get_character()," n : ",get_name(), " interacted with ",get_character()," n : ",area.get_parent().get_name())
		interaction(area.get_parent())
