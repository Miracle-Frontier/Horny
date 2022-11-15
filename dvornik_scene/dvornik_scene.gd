extends Node2D

const LEFT_MOUSE:int = 1;
const MAX_SCORE = 8
const MIN_DISTANCE = 800
const MAX_DISTANCE = 500000
const Rofi = preload("res://dvornik_scene/cleaner/rofi/rofi.tscn")

export var garbage_count:int = 2
var _score:int = 0
var _max_player_x:float = 0.0
var loh_showd:bool = false
var xxx_showd:bool = false

onready var player:KinematicBody2D = $Player
onready var broom:Node2D = $Broom
onready var camera:Camera2D = $Camera2D


func _ready() -> void:
	randomize()
	camera.smoothing_enabled = false
	camera.global_position.x = clamp(player.global_position.x, MIN_DISTANCE, MAX_DISTANCE)
	_update_score()
	yield(get_tree(),"idle_frame")
	camera.smoothing_enabled = true
	broom.set_player($Player)
	
	var current_tween = create_tween()
	current_tween.set_trans(Tween.TRANS_CUBIC)
	current_tween.tween_property($Dark/Background, "modulate:a", 0.0, 8.0)


func clear_garbage() -> void:
	broom.clear()


func garbage_cleared() -> void:
	_score += 1
	_update_score()
	if _score >= MAX_SCORE:
		_clear_all_garbage()
		_show_rofi()


func _show_rofi() -> void:
	var rofi = Rofi.instance()
	player.get_parent().call_deferred("add_child", rofi)
	yield(rofi, "ready")
	var rofi_position:Vector2 = player.global_position
	rofi_position.x += get_viewport().size.x * 2
	rofi.global_position = rofi_position


func _clear_all_garbage() -> void:
	while true:
		var garbage:Node = get_tree().current_scene.find_node("Garbage*", false, true)
		if garbage == null:
			break
		garbage.name = "Delete"
		garbage.queue_free()


func _update_score() -> void:
	$UI/TextureProgress.value = _score


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.get_button_index() == LEFT_MOUSE:
			clear_garbage()
			if randf() > 0.7:
				if randi() % 2 == 1:
					_loh()
				else:
					_xxx()


func _loh() -> void:
	if loh_showd:
		return
	loh_showd = true	
	$Loh.global_position = get_position_for_lox_xxx_sprite()


func _xxx() -> void:
	if xxx_showd:
		return
	xxx_showd = true
	$Xxx.global_position = get_position_for_lox_xxx_sprite()


func get_position_for_lox_xxx_sprite() -> Vector2:
	var sprite_position:Vector2 = player.global_position
	sprite_position.y -= rand_range(350, 500)
	sprite_position.x += get_viewport().size.x
	return sprite_position


func _process(_delta: float) -> void:
	camera.global_position.x = clamp(player.global_position.x, MIN_DISTANCE, MAX_DISTANCE)
