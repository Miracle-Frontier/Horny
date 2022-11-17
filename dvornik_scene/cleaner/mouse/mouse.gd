extends Sprite

const TWEEN_DURATION: float = 0.4

var shown:bool = false

func show_icon() -> void:
	_tween_show(self)
	shown = true


func hide_icon() -> void:
	call_deferred("_tween_hide")
	shown = false

func _tween_show(object:Object = self, duration: float = TWEEN_DURATION) -> SceneTreeTween:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(object, "modulate:a", 1.0, duration)
	return tween


func _tween_hide(object:Object = self, duration: float = TWEEN_DURATION):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(object, "modulate:a", 0.0, duration)


func _on_Area2D_body_entered(body: Node) -> void:
	if shown:
		_tween_hide()


func _on_Area2D_body_exited(body: Node) -> void:
	if shown:
		_tween_show()
