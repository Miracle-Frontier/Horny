extends Node2D

export(float) var open_speed:float = 20.0

var speed:float = 0
var open:bool = false

onready var up_sprite:Sprite = $Walls/UpperWallSprite
onready var up_sprite_collision:CollisionShape2D = $Walls/UppwerWallCollision
onready var low_sprite:Sprite = $Walls/LowerWallSprite
onready var low_sprite_collision:CollisionShape2D = $Walls/LowerWallCollision


func set_gate_size(up_y: float, low_y: float) -> void:
	up_sprite.global_position.y = up_y
	up_sprite_collision.global_position.y += up_y
	
	low_sprite.global_position.y = low_y
	low_sprite_collision.global_position.y += low_y


func _physics_process(delta: float) -> void:
	position.x -= speed * delta
	if open:
		_open()


func _open() -> void:
	up_sprite.global_position.y -= open_speed
	up_sprite_collision.global_position.y -= open_speed
	
	low_sprite.global_position.y += open_speed
	low_sprite_collision.global_position.y += open_speed


func damage(value:float) -> void:
	open = true	
	#queue_free()


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
