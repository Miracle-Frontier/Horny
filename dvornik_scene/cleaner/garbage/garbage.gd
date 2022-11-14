extends KinematicBody2D

signal cleared

const TWEEN_DURATION: float = 0.4

var _is_cleared:bool = false
onready var mouse_icon = $Mouse

func _ready():
	connect("cleared", get_parent(), "garbage_creared")

func show_clean_variant() -> void:
	twin_show(mouse_icon)


func hide_clean_variants() -> void:
	twin_hide(mouse_icon)


func clear() -> void:
	if _is_cleared: return
	_is_cleared = true
	emit_signal("cleared")
	yield(twin_hide(), "finished")
	$CollisionShape2D.disabled = true
	queue_free()	


func twin_show(object:Object = self, duration: float = TWEEN_DURATION) -> SceneTreeTween:
	var tween:SceneTreeTween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(object, "modulate:a", 1.0, duration)
	return tween


func twin_hide(object:Object = self, duration: float = TWEEN_DURATION) -> SceneTreeTween:
	var tween:SceneTreeTween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(object, "modulate:a", 0.0, duration)
	return tween
