extends RigidBody2D

const Boom:PackedScene = preload("res://cat_queen_the_meme_lord_scene/explosion/explusion.tscn")

export var speed:float = 1.0
export var armor:int = 3

var direction:Vector2 = Vector2.LEFT
var clone:bool = false
var damaged:bool = false

func _ready() -> void:
	angular_velocity = rand_range(-2, 2)
	linear_velocity += direction * speed


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
	
	
func damage(value:float) -> void:
	if damaged:
		return
	armor -= value
	if armor > 0:
		return

	damaged = true
	if not clone:
		_create_small_rock()
		_create_small_rock()
		_create_small_rock()
		_create_small_rock()
	
	#var boom:Node2D = Boom.instance()
	#get_tree().current_scene.add_child(boom)
	#boom.global_position = global_position
	
	yield(create_tween().tween_property(self, "modulate:a", 0.0, 0.1), "finished")
	queue_free()


func _set_casle(scale:Vector2) -> void:
	# гоавнокод
	$Sprite.scale = scale
	$CollisionShape2D2.scale = scale
	pass


func _create_small_rock() -> void:
	var rock:RigidBody2D = self.duplicate()
	rock.clone = true
	rock.direction.x = rand_range(-1, 1)
	rock.direction.y = rand_range(-1, 1)
	rock.speed = rand_range(200, 300)
	rock._set_casle(scale * rand_range(0.5, 0.8))
	get_parent().call_deferred("add_child", rock)
