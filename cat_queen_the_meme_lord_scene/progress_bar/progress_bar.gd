extends TextureProgress

signal is_over

onready var timer:Timer = $Timer

func _ready() -> void:
	
	pass


func _on_Timer_timeout() -> void:
	value += 1
	if value >= max_value:
		_on_end()


func _on_end() -> void:
	timer.stop()
	emit_signal("is_over")


func stop_time() -> void:
	value = 0
	timer.stop()
	
func start_time():
	timer.start()
