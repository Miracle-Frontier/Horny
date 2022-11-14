extends Node


export(Array, PackedScene) var garbages = []


func get_random_garbage() -> Node2D:
	var garbage = garbages[randi() % garbages.size()].instance()
	return garbage
