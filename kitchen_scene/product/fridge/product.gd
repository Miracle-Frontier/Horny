extends Node2D

signal drag_start

export(bool) var draggable:bool = true

onready var save_position:Vector2 = position
onready var selected:bool = false
onready var grab:bool = false

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if selected and draggable:
		follow_mouse()


func follow_mouse() -> void:
	position = get_global_mouse_position()
	if position != save_position:
		emit_signal("drag_start")
	pass


func _on_Area2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		selected = event.pressed
		if not selected and not grab:
			position = save_position
