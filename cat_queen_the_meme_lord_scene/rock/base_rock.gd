extends KinematicBody2D

const Boom:PackedScene = preload("res://cat_queen_the_meme_lord_scene/explosion/explusion.tscn")

export var speed:float = 100.0
export var armor:int = 3
var rotation_value:int = rand_range(-2, 2)


func update_rotation():
	if rotation_value == 0:
		rotation_value += 1
	else:
		rotation_value *= rand_range(5, 8)


func _physics_process(delta: float) -> void:
	position.x -= speed * delta
	rotate(rotation_value * delta)


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
	
	
func damage(value:float) -> void:
	armor -= value
	if armor > 0:
		return

	var boom:Node2D = Boom.instance()
	get_tree().current_scene.add_child(boom)
	boom.global_position = global_position
	queue_free()	
