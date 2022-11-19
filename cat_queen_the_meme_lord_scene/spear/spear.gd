extends KinematicBody2D

var _speed:float = 50
var _direction:Vector2 = Vector2.ZERO
var move:bool = false
var action:bool = true
var down:bool = false

func _physics_process(delta: float) -> void:
	if not move:
		move_and_collide(_direction * _speed)


func _process(delta: float) -> void:
	if down:
		_speed += 1
		position += _direction * _speed


func set_direction(direction:Vector2) -> void:
	_direction = direction
	
	
func set_speed(speed: float) -> void:
	_speed = speed


func damage(value:float) -> void:
	_speed = 0
	_destroy()


func _destroy() -> void:
	_direction.x *= -1
	_direction.y *= -1
	_speed = 1
	down = true
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "modulate:a", 0.0, 0.3)
	
	tween.tween_callback(self, "queue_free")


func _on_Area2D_body_entered(body: Node) -> void:
	if not action or body == self:
		return
	_speed = 0
	move = false
	action = false
	print(body.name)
	
	yield(get_tree().create_timer(0.5), "timeout")
	$CollisionPolygon2D.call_deferred("set_disabled", true)
	_destroy()
	
	#body.call_deferred("add_child", self)
	#$CollisionPolygon2D.call_deferred("set_disabled", true)

