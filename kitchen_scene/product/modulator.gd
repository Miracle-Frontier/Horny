extends Node

signal press_to(node)


const LEFT_MOUSE:int = 1;

onready var parent:Control = get_parent()
onready var a:float = parent.modulate.a
onready var r:float = parent.modulate.r
onready var g:float = parent.modulate.g
onready var b:float = parent.modulate.b


func modulate_off() -> void:
	parent.modulate.a = a
	parent.modulate.r = r
	parent.modulate.g = g
	parent.modulate.b = b


func modulate_on() -> void:
	parent.modulate.r = 255
