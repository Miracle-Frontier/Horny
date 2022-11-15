extends KinematicBody2D

onready var mouse_icon = $Mouse

func show_addition() -> void:
	mouse_icon.show_icon()


func hide_addition() -> void:
	mouse_icon.hide_icon()
