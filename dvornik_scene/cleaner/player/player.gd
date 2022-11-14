extends KinematicBody2D

enum TurnSade { NONE = 0, LEFT = 1, RIGHT = 2}

export var speed:float = 300
onready var animation:AnimationPlayer = $AnimationPlayer
onready var clear_area:Area2D = $ClearArea
var current_turn = TurnSade.NONE

func _ready() -> void:
	turn_side(TurnSade.LEFT)
	
	
func get_clear_area() -> Area2D:
	return clear_area	
	
	
func get_turn_side() -> int:
	return current_turn
	
	
func _physics_process(delta: float) -> void:
	var direction = Vector2(0,10)
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
		turn_side(TurnSade.LEFT)
	elif Input.is_action_pressed("ui_right"):
		direction.x = 1;
		turn_side(TurnSade.RIGHT)
		
	direction *= speed	
	move_and_slide(direction)
	update_animation(direction.x != 0)

func update_animation(isWalk: bool):
	if isWalk:
		$WalkingAnimation.play("Walking")
	else:
		$WalkingAnimation.play("Idle")
	


func turn_side(side: int) -> void:
	if current_turn == side: return
	match side:
		TurnSade.LEFT:
			animation.play("turn_left")
		TurnSade.RIGHT:
			animation.play("turn_right")
	current_turn = side


func _on_Area2D_body_entered(body: Node) -> void:
	if body.has_method("show_clean_variant"):
		body.show_clean_variant()


func _on_Area2D_body_exited(body: Node) -> void:
	if body.has_method("hide_clean_variants"):
		body.hide_clean_variants()
