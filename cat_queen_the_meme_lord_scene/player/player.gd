extends KinematicBody2D

class_name PlayerCat

signal player_contacted


const Bullet:PackedScene = preload("res://cat_queen_the_meme_lord_scene/bullet/bullet.tscn")
const INVULNERABILITY_TIME: float = 1.0
const EMIT_TIMER: float = 0.2
const DIRECTION_LEFT:float = -1.0
const DIRECTION_RIGHT:float = 1.0
const DIRECTION_UP:float = -1.0
const DIRECTION_DOWN:float = 1.0

enum TurnSide { NONE = 0, LEFT = 1, RIGHT = 2}

const speed : int = 500
const acceleration : float = 1.0
const friction : float = 0.1
var velocity : Vector2
var direction : Vector2
var time_between_emit_signal:float = 0
var fire_ready:bool = true
var contact_bodys:Array = []

onready var damage_fx:Node = $DamageFx
onready var gun:Node2D = $Gun
onready var flasher:Node = $Flasher
onready var invulnerability:bool = false
onready var invulnerability_timer:float = INVULNERABILITY_TIME

var controls_blocked = false

func _physics_process(delta: float) -> void:
	
	direction = Vector2(0,0)
	if not controls_blocked:
		direction.x = float(Input.is_action_pressed("ui_right")) - float(Input.is_action_pressed("ui_left"))
		direction.y = float(Input.is_action_pressed("ui_down")) - float(Input.is_action_pressed("ui_up"))
		direction = direction.normalized()
		if Input.is_action_pressed("ui_accept"):
			_fire()
			$Sprite.modulate.a = 0
			$AnimatedSprite.modulate.a = 1
		else:
			$Sprite.modulate.a = 1
			$AnimatedSprite.modulate.a = 0
	
	velocity = lerp(velocity, direction * speed, acceleration * delta)
	velocity = lerp(velocity, Vector2.ZERO, friction * delta)

	velocity = move_and_slide(velocity)
	
	move_and_slide(velocity)
	
	if direction.x > 0:
		transform.x.x = abs(transform.x.x)
	elif direction.x < 0:
		transform.x.x = -abs(transform.x.x)

func _fire() -> void:
	if not fire_ready:
		return
	fire_ready = false	
	var bullet:Node2D = Bullet.instance()
	bullet.direction.x = transform.x.x
	get_parent().add_child(bullet)
	bullet.global_position = gun.global_position
	yield(get_tree().create_timer(0.001),"timeout")
	fire_ready = true


func _process(delta: float) -> void:
	if invulnerability:
		invulnerability_timer -= delta
		if invulnerability_timer <= 0:
			invulnerability = false
	elif contact_bodys.size() > 0:
		time_between_emit_signal += delta
		if time_between_emit_signal >= EMIT_TIMER:
			_player_contacted()
			#print("long player contac!")


func _player_contacted() -> void:
	time_between_emit_signal = 0.0
	emit_signal("player_contacted")
	damage_fx.play(contact_bodys[0])
	flasher.flash(INVULNERABILITY_TIME)
	invulnerability = true
	invulnerability_timer = INVULNERABILITY_TIME


func _on_Area_body_entered(body: Node) -> void:
	if body.is_in_group("damage"):
		contact_bodys.append(body)

func _on_Area_body_exited(body: Node) -> void:
	contact_bodys.remove(contact_bodys.find(body)) 
