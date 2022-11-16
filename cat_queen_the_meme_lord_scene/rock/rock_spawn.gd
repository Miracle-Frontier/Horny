extends Node2D

const Rock1:PackedScene = preload ("res://cat_queen_the_meme_lord_scene/rock/rock1.tscn")
const Rock2:PackedScene = preload("res://cat_queen_the_meme_lord_scene/rock/rock2.tscn")
const Rock3:PackedScene = preload("res://cat_queen_the_meme_lord_scene/rock/rock3.tscn")
const rocks:Array = [Rock1, Rock2, Rock3]


func create_rock(y_position:float, speed:float, scale:Vector2) -> void:
	var rock = rocks[randi() % rocks.size()].instance()
	get_tree().current_scene.add_child(rock)
	rock.speed = speed
	rock.global_position = self.position
	rock.global_position.y = y_position
	rock.scale = scale
