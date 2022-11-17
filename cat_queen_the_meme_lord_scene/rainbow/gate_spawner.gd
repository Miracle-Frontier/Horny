extends Node2D

export(float) var speed = 300

const Gate:PackedScene = preload("res://cat_queen_the_meme_lord_scene/rainbow/gate.tscn")

func create_gate(up_y: float, low_y: float, inverse:bool) -> void:
	var rainbow:Node2D = Gate.instance()
	get_parent().add_child(rainbow)
	rainbow.speed = speed if inverse else speed * -1
	rainbow.global_position.x = 1700 if inverse else -100
	
	
	rainbow.set_gate_size(up_y, low_y)
