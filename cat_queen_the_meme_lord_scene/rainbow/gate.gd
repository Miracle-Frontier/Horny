extends Node2D

var speed:float = 300

onready var up_sprite:Sprite = $Walls/UpperWallSprite
onready var up_sprite_collision:CollisionShape2D = $Walls/UppwerWallCollision
onready var low_sprite:Sprite = $Walls/LowerWallSprite
onready var low_sprite_collision:CollisionShape2D = $Walls/LowerWallCollision


func set_gate_size(up_y: float, low_y: float) -> void:
	up_sprite.global_position.y -= up_y
	up_sprite_collision.global_position.y -= up_y
	
	low_sprite.global_position.y += low_y
	low_sprite_collision.global_position.y += low_y


func _physics_process(delta: float) -> void:
	position.x -= speed * delta
	pass


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
