extends KinematicBody2D

class_name Rofi

signal rofi_is_now_agressive

onready var mouse_icon = $Mouse

func show_addition() -> void:
	mouse_icon.show_icon()


func hide_addition() -> void:
	mouse_icon.hide_icon()


var is_player_near = false

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		is_player_near = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		is_player_near = false


func _on_AgressiveArea_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("rofi_is_now_agressive")
