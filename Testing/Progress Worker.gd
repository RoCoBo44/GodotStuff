extends TextureProgress

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func set_name(name):
	$Label.set_text(name)

func _actualize(total,money,cantidad):
	if (cantidad > 0):
		$Label.set_text(str(money/cantidad))
		$Tween.interpolate_property(self, "value", value, 100*money/total, 1, Tween.TRANS_CIRC, Tween.EASE_IN_OUT)
		$Tween.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
