extends Node2D

const TWEEN_DURATION: float = 0.2
const TurnSide = preload("res://dvornik_scene/cleaner/player/player.gd").TurnSade

var player: Node2D
var current_tween:SceneTreeTween



func set_player(player:Node2D) -> void:
	self.player = player


func clear() -> void:
	global_position = player.get_clear_area().global_position
	twin_show()
	$BroomArea/CollisionShape2D.disabled = false
	show_animation()

func show_animation():
	match player.get_turn_side():
		TurnSide.LEFT:
			$AnimationPlayer.play("left_clear")
		TurnSide.RIGHT:
			$AnimationPlayer.play("right_clear")


func cleared() -> void:
	$BroomArea/CollisionShape2D.disabled = true
	twin_hide()


func twin_show(duration: float = TWEEN_DURATION) -> SceneTreeTween:
	if current_tween != null:
		current_tween.kill()
	current_tween = create_tween()
	current_tween.set_trans(Tween.TRANS_CUBIC)
	current_tween.tween_property(self, "modulate:a", 1.0, duration)
	return current_tween


func twin_hide(duration: float = TWEEN_DURATION) -> SceneTreeTween:
	if current_tween != null:
		current_tween.kill()
	current_tween = create_tween()
	current_tween.set_trans(Tween.TRANS_CUBIC)
	current_tween.tween_property(self, "modulate:a", 0.0, duration)
	return current_tween


func _on_Area2D_body_entered(body: Node) -> void:
	print(body)
	if body.has_method("clear"):
		body.clear()
