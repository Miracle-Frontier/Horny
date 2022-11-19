extends Node2D



var selected:bool = false

onready var save_position:Vector2 = position


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if selected:
		follow_mouse()


func follow_mouse() -> void:
	position = get_global_mouse_position()
	pass


func _on_Area2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		selected = event.pressed
