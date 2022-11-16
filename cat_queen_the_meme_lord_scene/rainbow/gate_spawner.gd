extends Node2D

const Gate:PackedScene = preload("res://cat_queen_the_meme_lord_scene/rainbow/gate.tscn")

func create_gate(up_y: float, low_y: float) -> void:
	var rainbow:Node2D = Gate.instance()
	get_tree().current_scene.add_child(rainbow)
	rainbow.global_position.x = global_position.x
	
	rainbow.set_gate_size(up_y, low_y)
