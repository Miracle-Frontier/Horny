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
	
	
func _test() -> void:
	create_asteroid(600, 10, Vector2(2, 2), false)
	create_asteroid(600, 10, Vector2(2, 2), true)
	create_flappy_bird(500, 600, false)
	create_flappy_bird(500, 600, true)
	create_spear(Side.RIGHT, 500)
	shake_screen()


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
	print("time is over")
