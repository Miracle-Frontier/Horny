extends KinematicBody2D

const TWEEN_DURATION: float = 0.4
const LEFT_MOUSE:int = 1;
signal need_clear
onready var mouse_icon = $TextureRect
var blocked:bool = false
var active:bool = false

func _ready() -> void:
	pass


func show_clean_variant() -> void:
	var tween:SceneTreeTween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(mouse_icon, "modulate:a", 1.0, 0.5)
	yield(tween, "finished")
	active = true

func hide_clean_variants() -> void:
	active = false
	var tween:SceneTreeTween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(mouse_icon, "modulate:a", 0.0, 0.5)


func _on_TextureRect_gui_input(event: InputEvent) -> void:
	if blocked or not active: return
	if event is InputEventMouseButton:
		if event.is_pressed() and event.get_button_index() == LEFT_MOUSE:
			emit_signal("need_clear")


func set_blocked():
	blocked = true
	
	
func clear() -> void:
	print("garbage clear!")
	if blocked: return
	blocked = true
	$CollisionShape2D.disabled = true
	#yield(twin_hide(), "finished")
	queue_free()	


func twin_show(duration: float = TWEEN_DURATION) -> SceneTreeTween:
	var tween:SceneTreeTween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "modulate:a", 1.0, duration)
	return tween


func twin_hide(duration: float = TWEEN_DURATION) -> SceneTreeTween:
	var tween:SceneTreeTween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "modulate:a", 0.0, duration)
	return tween
