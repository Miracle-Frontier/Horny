extends KinematicBody2D

const LEFT_MOUSE:int = 1;
signal need_clear
onready var mouse_icon = $TextureRect
var blocked:bool = false
var active:bool = false

func _ready() -> void:
	pass


func _on_Area2D_body_entered(body: Node) -> void:
	if blocked: return
	var tween:SceneTreeTween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(mouse_icon, "modulate:a", 1.0, 0.5)
	yield(tween, "finished")
	active = true
	

func _on_Area2D_body_exited(body: Node) -> void:
	if blocked: return
	active = false
	var tween:SceneTreeTween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(mouse_icon, "modulate:a", 0.0, 0.5)


func _on_TextureRect_gui_input(event: InputEvent) -> void:
	if blocked or not active: return
	if event is InputEventMouseButton:
		if event.is_pressed() and event.get_button_index() == LEFT_MOUSE:
			emit_signal("need_clear", self)


func set_blocked():
	blocked = true
