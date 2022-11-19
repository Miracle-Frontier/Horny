extends Node2D

signal reset_time

const Side = preload("res://cat_queen_the_meme_lord_scene/spear/spear_spawner.gd").Side
const Rainbow:PackedScene = preload("res://cat_queen_the_meme_lord_scene/rainbow/gate.tscn")


onready var asteroid_spawner:Node2D = $RockSpawn
onready var gate_spawner:Node2D = $GateSpawner
onready var spear_spawner:Node2D = $SpearSpawner
onready var shake:Node = $ScreenShake
onready var progress:Node = $UI/ProgressBar

func _ready() -> void:
	get_tree().set_current_scene(self) # костыль
	$UI/ProgressBar.connect("is_over", self, "time_over")
	shake.set_camera($Camera2D)
	$Player.connect("player_contacted", self, "reset_time")
	_test()
	
	var tween_background_alpha = create_tween()
	tween_background_alpha.set_trans(Tween.TRANS_CUBIC)
	tween_background_alpha.tween_property($ParallaxBackground/ParallaxLayer/Background, "modulate:a", 1.0, 2.5)
	
	
func _test() -> void:
	#create_asteroid(600, 300, Vector2(2, 2), true)
	#create_asteroid(600, 300, Vector2(2, 2), false)
	#create_asteroid(600, 300, Vector2(2, 2), false)
	#create_flappy_bird(500, 600, true)
	#create_flappy_bird(500, 600, false)
	#create_spear(Side.RIGHT, 200)
	create_spear(Side.UP, 200)
	create_spear(Side.LEFT, 500)
	create_spear(Side.RIGHT, 200)
	create_spear(Side.DOWN, 800)
	#shake_screen()


func _process(delta):
	#print(get_viewport().get_mouse_position().y
	pass


func create_asteroid(y_position:float, speed:float, scale:Vector2, inverse:bool) -> void:
	asteroid_spawner.create_rock(y_position, speed, scale, inverse)


func create_flappy_bird(up_y: float, low_y: float, inverse:bool) -> void:
	gate_spawner.create_gate(up_y, low_y, inverse)


func create_spear(var side:int, position:float) -> void:
	spear_spawner.create_spear(side, position)


func shake_screen() -> void:
	shake.apply_shake()


func reset_time() -> void:
	shake_screen()
	progress.reset_time()


func time_over() -> void:
	print("time is over = inverse")
	reset_time()
	_test()
	_inverse_stars()
	
	
func _inverse_stars() -> void:
	$InverseFx.play()
	var stars1:CPUParticles2D = $Bg/Stars1 if $Bg/Stars1.modulate.a == 1.0 else $Bg/Stars2
	var stars2:CPUParticles2D = $Bg/Stars2 if $Bg/Stars2.modulate.a == 0.0 else $Bg/Stars1
	
	var tween:SceneTreeTween = create_tween()
	#tween.parallel().tween_property(stars1, "initial_velocity", 0.0, 2.0)
	tween.parallel().tween_property(stars1, "modulate:a", 0.0, 2.0)
	#tween.parallel().tween_property(stars2, "initial_velocity", 500.0, 2.0)
	tween.parallel().tween_property(stars2, "modulate:a", 1.0, 2.0)
