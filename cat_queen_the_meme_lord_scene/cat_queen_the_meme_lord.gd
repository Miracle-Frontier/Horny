extends Node2D

const Rainbow:PackedScene = preload("res://cat_queen_the_meme_lord_scene/rainbow/gate.tscn")

onready var asteroid_spawner:Node2D = $RockSpawn
onready var gate_spawner:Node2D = $GateSpawner


func _ready() -> void:
	create_asteroid(600, 200, Vector2(2, 2))
	create_flappy_bird(500, 600)

func _process(delta):
	print(get_viewport().get_mouse_position().y)

func create_asteroid(y_position:float, speed:float, scale:Vector2) -> void:
	asteroid_spawner.create_rock(y_position, speed, scale)


func create_flappy_bird(up_y: float, low_y: float) -> void:
	gate_spawner.create_gate(up_y, low_y)


func create_spear() -> void:
	pass
