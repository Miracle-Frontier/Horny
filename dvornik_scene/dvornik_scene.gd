extends Node2D

class_name DvornikScene

const LEFT_MOUSE:int = 1;
const MAX_SCORE = 8
const MIN_DISTANCE = 800
const MAX_DISTANCE = 500000

const FADEOUT_TIME = 8.0
const _rofi = preload("res://dvornik_scene/cleaner/rofi/rofi.tscn")


var rofi: Rofi
export var garbage_count:int = 2
var _score:int = 0
var _max_player_x:float = 0.0
var loh_showd:bool = false
var xxx_showd:bool = false
var rofi_initialized: bool = false


onready var player:KinematicBody2D = $Player
onready var broom:Node2D = $Broom
onready var camera:Camera2D = $Camera2D
onready var garbage_container = $GarbageContainer

var shader_animation
var input_is_active = true

func _ready() -> void:
	randomize()
	camera.smoothing_enabled = false
	camera.global_position.x = clamp(player.global_position.x, MIN_DISTANCE, MAX_DISTANCE)
	_update_score()
	_connet_garbage()
	yield(get_tree(),"idle_frame")
	camera.smoothing_enabled = true
	broom.set_player($Player)
	_fade_out_dark_bg()

	shader_animation = $Dark/ShaderBlank
	shader_animation.get_parent().remove_child(shader_animation)
	var canvas = CanvasLayer.new()
	canvas.layer = 4
	get_parent().add_child(canvas)
	canvas.add_child(shader_animation)
	shader_animation.get_node("AnimationPlayer").connect("next_scene",self,"next_scene")
	$GarbageContainer.connect("garbage_cleared", self, "_show_rofi")	

func _connet_garbage() -> void:
	var garbages:Array = $GarbageContainer.get_children()
	for garbage in garbages:
		garbage.connect("cleared", self, "garbage_cleared")


func _fade_out_dark_bg() -> void:
	$Dark/Background.visible = true
	var current_tween = create_tween()
	current_tween.set_trans(Tween.TRANS_CUBIC)
	current_tween.tween_property($Dark/Background, "modulate:a", 0.0, FADEOUT_TIME)


func clear_garbage() -> void:
	broom.clear()


func garbage_cleared() -> void:
	_score += 1
	_update_score()
	if _score >= MAX_SCORE:
		$GarbageContainer.need_remove = true


func _show_rofi() -> void:
	if rofi_initialized:
		return
	print("show rofi")	
	rofi_initialized = true	
	rofi = _rofi.instance()

	player.get_parent().call_deferred("add_child", rofi)
	yield(rofi, "ready")
	var rofi_position:Vector2 = player.global_position
	rofi_position.x += get_viewport().size.x * 2
	rofi_position.y = $RofiHeightPosition.position.y
	rofi.global_position = rofi_position
	rofi.connect("rofi_is_now_agressive", self, "rofi_opens_portal")

var cat_queen_scene = preload("res://cat_queen_the_meme_lord_scene/cat_queen_the_meme_lord.tscn")

func next_scene(): # TODO : ВЫЗВАТЬ new ShaderMaterial, иначе все будет лагать. Плюс queue_free()
	#enable_camera = false
	# TODO: НЕ НАДО НИКУДА ДВИГАТЬ КАМЕРУ, ПРОСТО СТАВЬ ЕЕ В ROOT
	var meow_scene =cat_queen_scene.instance()
	meow_scene.modulate.a = 0.0
	get_parent().add_child(meow_scene)
	var current_tween = create_tween()
	current_tween.set_trans(Tween.TRANS_CUBIC)
	current_tween.tween_property(self, "modulate:a", 0.0, 2.5)
	var background_tween = create_tween()
	background_tween.set_trans(Tween.TRANS_CUBIC)
	background_tween.tween_property($ParallaxBackground/ParallaxLayer/Bg, "modulate:a", 0.0, 2.5)
	var sound_tween = create_tween()
	sound_tween.set_trans(Tween.TRANS_CUBIC)
	sound_tween.tween_property($CityVibe, "volume_db", -50.0, 2.5)
	var meow_tween = create_tween()
	meow_tween.set_trans(Tween.TRANS_CUBIC)
	meow_tween.tween_property(meow_scene, "modulate:a", 1.0, 2.5)
	player.show_particles = false
	player.global_position.x = 1200
	$BroomSweep.volume_db = -100.0
	$Portal.play(0.1)
	yield(get_tree().create_timer(2), "timeout")
	#player.global_position.x = 1200
	$UI.queue_free()
	yield(get_tree().create_timer(2), "timeout")
	queue_free()


func _update_score() -> void:
	$UI/TextureProgress.value = _score

var speaking_to_rofi = false

var enable_camera = true

func cutscene_ended(_name):
	var current_tween = create_tween()
	current_tween.set_trans(Tween.TRANS_CUBIC)
	current_tween.tween_property($Camera2D, "zoom:x", 1.0, 1)
	var current_tween2 = create_tween()
	current_tween2.set_trans(Tween.TRANS_CUBIC)
	current_tween2.tween_property($Camera2D, "zoom:y", 1.0, 1)
	camera.global_position.x = clamp(player.global_position.x, MIN_DISTANCE, MAX_DISTANCE)
	yield(get_tree().create_timer(1), "timeout")
	enable_camera = true
	speaking_to_rofi = false
	#get_parent().add_child(scene.instance())
	#queue_free()
	pass


func rofi_opens_portal():
	var light = rofi.get_node("Light")
	camera.global_position.x = clamp(rofi.global_position.x, MIN_DISTANCE, MAX_DISTANCE)
	saved_position = camera.global_position.y
	camera.global_position.y -= 100
	enable_camera = false
	speaking_to_rofi = true
	$Camera2D.smoothing_speed = 5
	var current_tween = create_tween()
	current_tween.set_trans(Tween.TRANS_CUBIC)
	$RofiSound.play()
	var sound_tween = create_tween()
	sound_tween.set_trans(Tween.TRANS_CUBIC)
	sound_tween.tween_property($CityVibe, "volume_db", -50.0, 2.5)
	current_tween.tween_property($Camera2D, "zoom:x", 0.45, 0.7)
	var current_tween2 = create_tween()
	current_tween2.set_trans(Tween.TRANS_CUBIC)
	current_tween2.tween_property($Camera2D, "zoom:y", 0.45, 0.7)
	yield(get_tree().create_timer(1.5), "timeout")
	enable_camera = false
	speaking_to_rofi = true
	var dialog = Dialogic.start("rofi_says_2")
	dialog.pause_mode = Node.PAUSE_MODE_PROCESS
	dialog.connect("timeline_end", self, "cutscene_ended_2")
	add_child(dialog)

var saved_position

func cutscene_ended_2(_name):
	enable_camera = true
	speaking_to_rofi = false
	#yield(get_tree().create_timer(0.3), "timeout")
	$Camera2D.smoothing_speed = 2
	camera.global_position.y = saved_position
	cutscene_ended("")
	shader_animation.get_node("AnimationPlayer").play("ShockWave")	


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.get_button_index() == LEFT_MOUSE:
			clear_garbage()
			if randf() > 0.8:
				if randi() % 2 == 1:
					_loh()
				else:
					_xxx()
	elif not speaking_to_rofi and (event is InputEventKey and event.scancode == KEY_E) and rofi.is_player_near:
		camera.global_position.x = clamp(rofi.global_position.x, MIN_DISTANCE, MAX_DISTANCE)
		enable_camera = false
		speaking_to_rofi = true
		var current_tween = create_tween()
		current_tween.set_trans(Tween.TRANS_CUBIC)
		current_tween.tween_property($Camera2D, "zoom:x", 0.75, 2)
		var current_tween2 = create_tween()
		current_tween2.set_trans(Tween.TRANS_CUBIC)
		current_tween2.tween_property($Camera2D, "zoom:y", 0.75, 2)
		yield(get_tree().create_timer(2), "timeout")
		var dialog = Dialogic.start("rofi_says")
		dialog.pause_mode = Node.PAUSE_MODE_PROCESS
		dialog.connect("timeline_end", self, "cutscene_ended")
		add_child(dialog)

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
	var mouse_pos = get_global_mouse_position()
	
	if enable_camera:
		camera.global_position.x = clamp(player.global_position.x, MIN_DISTANCE, MAX_DISTANCE)
	#camera.offset_h = (mouse_pos.x - global_position.x) / (1600 / 1.5)
	#camera.offset_h = (mouse_pos.x - global_position.x) / (900 / 1.5)
