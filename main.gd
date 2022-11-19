extends Node2D

func _ready():
	OS.set_use_vsync(true)
	Engine.target_fps = 60
