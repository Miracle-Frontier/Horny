extends KinematicBody2D

export var speed:float = 100.0
export var armor:int = 3
var rotation_value:int = rand_range(-2, 2)


func update_rotation():
	if rotation_value == 0:
		rotation_value += 1
	else:
		rotation_value *= rand_range(5, 8)


func _physics_process(delta: float) -> void:
	position.x -= speed * delta
	rotate(rotation_value * delta)


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
