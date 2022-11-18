extends Node2D

const SHAKE_STRENGTH: float  = 10.0
const SHAKE_DECAY_RATE: float = 3.0

onready var rand = RandomNumberGenerator.new()

var shake_strenght: float = SHAKE_STRENGTH
var shake_decay_rate: float = SHAKE_DECAY_RATE

var camera:Camera2D
var action:bool = false


func _ready() -> void:
	rand.randomize()


func set_camera(camera: Camera2D) -> void:
	self.camera = camera
	
	
func apply_shake(shake_strenght: float = SHAKE_STRENGTH, shake_decay_rate: float = SHAKE_DECAY_RATE) -> void:
	self.shake_strenght = shake_strenght
	self.shake_decay_rate = shake_decay_rate
	action = true


func _process(delta: float) -> void:
	if not action:
		return
		
	shake_strenght = lerp(shake_strenght, 0, shake_decay_rate * delta)
	camera.offset = get_random_offset()
	
	if shake_strenght == 0:
		action = false


func get_random_offset() -> Vector2:
	return Vector2(
			rand.randf_range(-shake_strenght, shake_strenght),
			rand.randf_range(-shake_strenght, shake_strenght)
			)
