extends Area2D


var direction:Vector2 = Vector2.RIGHT
var speed: float = 50


func _process(delta: float) -> void:
	position += direction * speed


func _on_Bullet_body_entered(body: Node) -> void:

	if body is KinematicBody2D:
		if body.has_method("damage"):
			body.damage(1.0)
		else:
			print(str(body) + " no has damage method!")	
	elif body is StaticBody2D:
		if body.get_parent().has_method("damage"):
			body.get_parent().damage(1.0)
		else:
			print(str(body.get_parent()) + " no has damage method!")	
		
	queue_free()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
