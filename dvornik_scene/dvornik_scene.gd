extends Node2D

const LEFT_MOUSE:int = 1;

const min_distance:float = 250.0

export var garbage_count:int = 2
var _score:int = 0
var _max_player_x:float = 0.0

onready var player:KinematicBody2D = $Player
onready var broom:Node2D = $Broom
onready var camera:Camera2D = $Camera2D

func _ready() -> void:
	randomize()
	camera.smoothing_enabled = false
	camera.global_position.x = clamp(player.global_position.x,800,500000)
	_update_score()
	yield(get_tree(),"idle_frame")
	camera.smoothing_enabled = true
	broom.set_player($Player)
	
	var current_tween = create_tween()
	current_tween.set_trans(Tween.TRANS_CUBIC)
	current_tween.tween_property($Dark/Background, "modulate:a", 0.0, 8.0)

func clear_garbage() -> void:
	broom.clear()

func garbage_creared() -> void:
	_score += 1
	_update_score()

func _update_score() -> void:
	$UI/TextureProgress.value = _score

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.get_button_index() == LEFT_MOUSE:
			clear_garbage()


func _process(_delta: float) -> void:
	camera.global_position.x = clamp(player.global_position.x,800,500000)
