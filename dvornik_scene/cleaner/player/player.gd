extends KinematicBody2D

enum TurnSade { NONE = 0, LEFT = 1, RIGHT = 2}

export var speed:float = 300
onready var animation:AnimationPlayer = $AnimationPlayer
var current_turn = TurnSade.NONE

func _ready() -> void:
	turn_side(TurnSade.LEFT)
	
	
func init_broom(broom: Node2D) -> void:
	broom.set_clear_area($ClearArea)	
	
	
func _physics_process(delta: float) -> void:
	var direction = Vector2(0,10)
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
		turn_side(TurnSade.LEFT)
	elif Input.is_action_pressed("ui_right"):
		direction.x = 1;
		turn_side(TurnSade.RIGHT)
	move_and_slide(direction * speed)


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
