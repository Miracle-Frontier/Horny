extends Node2D

const Gate:PackedScene = preload("res://cat_queen_the_meme_lord_scene/rainbow/gate.tscn")

func create_gate(pos_x: float, up_y: float, low_y: float, speed: float, inverse:bool) -> void:
	var rainbow:Node2D = Gate.instance()
	get_parent().add_child(rainbow) 
	rainbow.speed = speed if inverse else speed * -1
	rainbow.global_position.x = pos_x
	
	rainbow.set_gate_size(up_y, low_y)
