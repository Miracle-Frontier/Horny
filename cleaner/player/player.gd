extends KinematicBody2D

export var speed:float = 300

func _physics_process(delta: float) -> void:
	var direction = Vector2(0,10)
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	elif Input.is_action_pressed("ui_right"):
		direction.x = 1;
	move_and_slide(direction * speed)
