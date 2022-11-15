extends Node2D

const TWEEN_DURATION: float = 0.2
const TurnSide = preload("res://dvornik_scene/cleaner/player/player.gd").TurnSide
const SMOKE_POSITION_OFFSET: float = 70.0
const SmokeEffect = preload("res://dvornik_scene/cleaner/smoke/smoke.tscn")

var player: Player
var current_tween:SceneTreeTween


func set_player(_player:Node2D) -> void:
	self.player = _player


func clear() -> void:
	var turn = player.get_turn_side()
	global_position = player.get_clear_area().global_position
	
	global_position.y -= 70
	global_position.x += 70 * (1 if turn==player.TurnSide.RIGHT else -1)
	twin_show()
	$BroomArea/CollisionShape2D.disabled = false
	_show_animation()
	_show_smoke()
	get_parent().get_node("BroomSweep").play()


func _show_animation() -> void:
	match player.get_turn_side():
		TurnSide.LEFT:
			$AnimationPlayer.play("left_clear")
		TurnSide.RIGHT:
			$AnimationPlayer.play("right_clear")


func _show_smoke() -> void:
	var smoke:Particles2D = SmokeEffect.instance()
	get_tree().current_scene.add_child(smoke)
	smoke.emitting = true
	var smoke_posotion:Vector2 = global_position
	smoke_posotion.y += SMOKE_POSITION_OFFSET
	smoke.global_position = smoke_posotion
	
	match player.get_turn_side():
		TurnSide.LEFT:
			smoke.left()
		TurnSide.RIGHT:
			smoke.right()


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
	if body.has_method("clear"):
		body.clear()
