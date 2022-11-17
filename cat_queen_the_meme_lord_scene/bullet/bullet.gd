extends Area2D


var direction:Vector2 = Vector2.RIGHT
var speed: float = 100


func _process(delta: float) -> void:
	position += direction * speed


func _on_Bullet_body_entered(body: Node) -> void:
	
	pass # Replace with function body.
