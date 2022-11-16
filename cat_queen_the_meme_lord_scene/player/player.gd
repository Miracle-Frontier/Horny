extends KinematicBody2D

const DIRECTION_LEFT:float = -1.0
const DIRECTION_RIGHT:float = 1.0
const DIRECTION_UP:float = -1.0
const DIRECTION_DOWN:float = 1.0

enum TurnSide { NONE = 0, LEFT = 1, RIGHT = 2}

const speed : int = 500
const acceleration : float = 1.0
const friction : float = 0.1
var velocity : Vector2
var direction : Vector2

func _physics_process(delta: float) -> void:
	direction.x = float(Input.is_action_pressed("ui_right")) - float(Input.is_action_pressed("ui_left"))
	direction.y = float(Input.is_action_pressed("ui_down")) - float(Input.is_action_pressed("ui_up"))
	direction = direction.normalized()
	
	velocity = lerp(velocity, direction * speed, acceleration * delta)
	velocity = lerp(velocity, Vector2.ZERO, friction * delta)

	velocity = move_and_slide(velocity)
	
	move_and_slide(velocity)
	
	if direction.x > 0:
		transform.x.x = abs(transform.x.x)
	elif direction.x < 0:
		transform.x.x = -abs(transform.x.x)
