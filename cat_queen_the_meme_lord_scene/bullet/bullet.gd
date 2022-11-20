extends Area2D


var direction:Vector2 = Vector2.RIGHT
var speed: float = 20

onready var smoketrail:Line2D = $Smoketrail

func _ready() -> void:
	smoketrail.connect("end_smoke", self, "queue_free")


func _physics_process(delta: float) -> void:
	position += direction * speed
	smoketrail.gravity = direction * -1
	

func _process(delta: float) -> void:
	if speed == 0:
		modulate.a *= 0.95

func _on_Bullet_body_entered(body: Node) -> void:
	if body.is_in_group("rock"):
			body.damage(1.0)
	#else:
	#	print(str(body) + " no has damage method!")
	speed = 0
	remove_child($Sprite)
	remove_child($CollisionShape2D)
	#queue_free()



func _on_VisibilityNotifier2D_screen_exited() -> void:
	speed = 0
