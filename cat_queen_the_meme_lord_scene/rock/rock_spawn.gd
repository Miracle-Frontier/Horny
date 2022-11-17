extends Node2D

const Rock1:PackedScene = preload ("res://cat_queen_the_meme_lord_scene/rock/rock1.tscn")
const Rock2:PackedScene = preload("res://cat_queen_the_meme_lord_scene/rock/rock2.tscn")
const Rock3:PackedScene = preload("res://cat_queen_the_meme_lord_scene/rock/rock3.tscn")
const rocks:Array = [Rock1, Rock2, Rock3]


func create_rock(y_position:float, speed:float, scale:Vector2, inverse:bool) -> void:
	var rock = rocks[randi() % rocks.size()].instance()
	get_parent().add_child(rock)
	rock.speed = speed if inverse else speed * -1
	rock.global_position.x = 1600 if inverse else 0
	rock.global_position.y = y_position
	rock.scale = scale
