extends Node2D

const Rock1:PackedScene = preload ("res://cat_queen_the_meme_lord_scene/rock/rock1.tscn")
const Rock2:PackedScene = preload("res://cat_queen_the_meme_lord_scene/rock/rock2.tscn")
const Rock3:PackedScene = preload("res://cat_queen_the_meme_lord_scene/rock/rock3.tscn")
const rocks:Array = [Rock1, Rock2, Rock3]


func create_rock(pos_x:float, y_position:float, speed:float, scale:Vector2, inverse:bool) -> void:
	var rock:RigidBody2D = rocks[randi() % rocks.size()].instance()
	rock.direction = Vector2.LEFT if inverse else Vector2.RIGHT
	rock.speed = speed
	rock._set_casle(scale)
	get_parent().add_child(rock)
	if pos_x!=0:
		rock.global_position.x = pos_x
	else:
		rock.global_position.x = global_position.x if inverse else -200
	rock.global_position.y = y_position
