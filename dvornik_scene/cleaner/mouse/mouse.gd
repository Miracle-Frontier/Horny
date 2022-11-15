extends Sprite

const TWEEN_DURATION: float = 0.4


func show_icon() -> void:
	_tween_show(self)


func hide_icon() -> void:
	_tween_hide(self)


func _tween_show(object:Object = self, duration: float = TWEEN_DURATION) -> SceneTreeTween:
	var tween:SceneTreeTween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(object, "modulate:a", 1.0, duration)
	return tween


func _tween_hide(object:Object = self, duration: float = TWEEN_DURATION) -> SceneTreeTween:
	var tween:SceneTreeTween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(object, "modulate:a", 0.0, duration)
	return tween
