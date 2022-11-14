extends Node2D

const TWEEN_DURATION: float = 0.4

onready var clear_area:Area2D


func set_clear_area(clear_area:Area2D):
	self.clear_area = clear_area


func clear() -> void:
	global_position = clear_area.global_position
	$AnimationPlayer.play("clear")
	twin_show()
	$BroomArea/CollisionShape2D.disabled = false


func cleared() -> void:
	$BroomArea/CollisionShape2D.disabled = true
	twin_hide()


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


func _on_Area2D_body_entered(body: Node) -> void:
	print(body)
	if body.has_method("clear"):
		body.clear()
