extends TextureProgress

func _ready():
	pass # Replace with function body.
func set_name(name):
	$Label.set_text(name)

func _actualize(total,money,cantidad):
	if (cantidad > 0):
		$Label.set_text(str(money/cantidad))
		$Tween.interpolate_property(self, "value", value, 100*money/total, 1, Tween.TRANS_CIRC, Tween.EASE_IN_OUT)
		$Tween.start()
	