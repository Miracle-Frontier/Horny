extends KinematicBody2D

signal cleared

const TWEEN_DURATION: float = 0.4

var _is_cleared:bool = false
onready var mouse_icon = $Mouse


func _ready():
	connect("cleared", get_parent(), "garbage_cleared")


func show_clean_variant() -> void:
	mouse_icon.show_icon()


func hide_clean_variants() -> void:
	if _is_cleared:
		return
	mouse_icon.hide_icon()


func clear() -> void:
	if _is_cleared:
		return
	_is_cleared = true
	emit_signal("cleared")
	yield(_tween_hide(), "finished")
	$CollisionShape2D.disabled = true
	queue_free()


func _tween_hide(object:Object = self, duration: float = TWEEN_DURATION) -> SceneTreeTween:
	var tween:SceneTreeTween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(object, "modulate:a", 0.0, duration)
	return tween
