extends Sprite

const TWEEN_DURATION: float = 0.4

enum State { IDLE =1,  CLEARING = 2}

var order:Array = []
var current_state = State.IDLE
var current_garbage:Node2D
var start_position:Vector2

func _ready() -> void:
	start_position = global_position
	modulate.a = 0.0


func clear(garbage: Node2D):
	if is_in_order(garbage): return
	order.append(garbage)
	

func is_in_order(garbage: Node2D) -> bool:
	for current in order:
		if current == garbage: return true
	return false
	
	
func _physics_process(delta: float) -> void:
	if current_state == State.IDLE and not order.empty():
		current_state = State.CLEARING
		var last_index:int  = order.size() - 1
		var current_garbage:Node2D = order[last_index]
		order.remove(last_index)
		handle_clear(current_garbage)


func handle_clear(garbage: Node2D) -> void:
	current_garbage = garbage
	twin_show()
	global_position = garbage.global_position
	$AnimationPlayer.play("clear")


func cleared() -> void:
	$AnimationPlayer.play("RESET")
	if not current_garbage == null:
		current_garbage.queue_free()
		current_garbage = null
	current_state = State.IDLE
	yield(twin_hide(), "finished")
	global_position = global_position


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
