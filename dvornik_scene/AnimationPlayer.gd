extends AnimationPlayer

signal next_scene

func switch_scene():
	emit_signal("next_scene")
	pass
	
