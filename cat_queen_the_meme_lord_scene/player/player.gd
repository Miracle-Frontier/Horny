extends KinematicBody2D

const DIRECTION_LEFT:float = -1.0
const DIRECTION_RIGHT:float = 1.0
const DIRECTION_UP:float = -1.0
const DIRECTION_DOWN:float = 1.0

enum TurnSide { NONE = 0, LEFT = 1, RIGHT = 2}

export(float) var speed = 200


func _physics_process(delta: float) -> void:
	var direction = Vector2(0, 0)
	if Input.is_action_pressed("ui_left"):
		direction.x = DIRECTION_LEFT
		_turn_side(TurnSide.LEFT)
	elif Input.is_action_pressed("ui_right"):
		direction.x = DIRECTION_RIGHT;
		_turn_side(TurnSide.RIGHT)
		
	if Input.is_action_pressed("ui_up"):
		direction.y = DIRECTION_UP
	elif Input.is_action_pressed("ui_down"):
		direction.y = DIRECTION_DOWN;
	
	direction *= speed	
	move_and_slide(direction)
	
	
func _turn_side(side: int) -> void:
	match side:
		TurnSide.LEFT:
			$AnimationPlayer.play("turn_left")
		TurnSide.RIGHT:
			$AnimationPlayer.play("tuen_right")
