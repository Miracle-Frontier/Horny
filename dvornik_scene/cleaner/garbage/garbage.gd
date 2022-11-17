extends KinematicBody2D

signal cleared
signal garbale_put_in_screen
signal garbage_out_of_screen

const TWEEN_DURATION: float = 0.4

var _is_cleared:bool = false
onready var mouse_icon = $Mouse


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


func _tween_hide(object:Object = self, duration: float = TWEEN_DURATION):
	var tween:SceneTreeTween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(object, "modulate:a", 0.0, duration)
	return tween


func _on_VisibilityNotifier2D_screen_entered() -> void:
	emit_signal("garbale_put_in_screen")


func _on_VisibilityNotifier2D_screen_exited() -> void:
	emit_signal("garbage_out_of_screen")
