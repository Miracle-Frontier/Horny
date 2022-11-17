extends KinematicBody2D

signal player_contacted

const INVULNERABILITY_TIME: float = 1.0
const EMIT_TIMER: float = 0.2
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
var contact:bool = false
var time_between_emit_signal:float = 0

onready var flasher:Node = $Flasher
onready var invulnerability:bool = false
onready var invulnerability_timer:float = INVULNERABILITY_TIME

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


func _process(delta: float) -> void:
	if invulnerability:
		invulnerability_timer -= delta
		if invulnerability_timer <= 0:
			invulnerability = false
	elif contact:
		time_between_emit_signal += delta
		if time_between_emit_signal >= EMIT_TIMER:
			time_between_emit_signal = 0.0
			emit_signal("player_contacted")
			print("long player contac!")


func _on_Area_body_entered(body: Node) -> void:
	if invulnerability:
		return
	contact = true
	time_between_emit_signal = 0.0
	emit_signal("player_contacted")
	flasher.flash(INVULNERABILITY_TIME)
	invulnerability = true
	invulnerability_timer = INVULNERABILITY_TIME
	
	
func _on_Area_body_exited(body: Node) -> void:
	contact = false
