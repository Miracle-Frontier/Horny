extends KinematicBody2D

class_name Player

enum TurnSide { NONE = 0, LEFT = 1, RIGHT = 2}
const GRAVITY:float = 10.0
const DIRECTION_LEFT:float = -1.0
const DIRECTION_RIGHT:float = 1.0
const SmokeEffect = preload("res://dvornik_scene/cleaner/smoke/smoke.tscn")

export var speed:float = 200

var _current_turn = TurnSide.NONE
var _smoke_ready:bool = true

onready var animation:AnimationPlayer = $AnimationPlayer
onready var clear_area:Area2D = $ClearArea
onready var walking_sound_player = get_parent().get_node("Walking")


func _ready() -> void:
	_turn_side(TurnSide.LEFT)
	
	
func get_clear_area() -> Area2D:
	return clear_area	
	
	
func get_turn_side() -> int:
	return _current_turn
	
	
func _physics_process(_delta: float) -> void:
	var direction = Vector2(0, GRAVITY)
	if Input.is_action_pressed("ui_left"):
		direction.x = DIRECTION_LEFT
		_turn_side(TurnSide.LEFT)
	elif Input.is_action_pressed("ui_right"):
		direction.x = DIRECTION_RIGHT;
		_turn_side(TurnSide.RIGHT)
		
	direction *= speed	
	move_and_slide(direction)
	_update_animation(direction.x != 0)


func _update_animation(isWalk: bool) -> void:
	if isWalk:
		$WalkingAnimation.play("Walking")
		walking_sound_player.stream_paused = false;
		_smoke()
	else:
		$WalkingAnimation.play("Idle")
		walking_sound_player.stream_paused = true;
	


func _smoke() -> void:
	if not _smoke_ready: return
	_smoke_ready = false
	
	var smoke:Particles2D = SmokeEffect.instance()
	smoke.amount = 5
	get_tree().current_scene.add_child(smoke)
	
	smoke.global_position = global_position
	
	match get_turn_side():
		TurnSide.LEFT:
			smoke.right()
		TurnSide.RIGHT:
			smoke.left()
			
	#yield(smoke, "tree_exiting")
	yield(get_tree().create_timer(rand_range(0.5, 2)), "timeout")
	_smoke_ready = true


func _turn_side(side: int) -> void:
	if _current_turn == side:
		return
	match side:
		TurnSide.LEFT:
			animation.play("turn_left")
		TurnSide.RIGHT:
			animation.play("turn_right")
	_current_turn = side


func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("garbage"):
		body.show_clean_variant()
	if body.has_method("show_addition"):
		body.show_addition()	


func _on_Area2D_body_exited(body: Node) -> void:
	if body.is_in_group("garbage"):
		body.hide_clean_variants()
	if body.has_method("hide_addition"):
		body.hide_addition()
