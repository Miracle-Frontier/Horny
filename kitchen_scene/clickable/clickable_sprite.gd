extends TextureButton

signal press_to(node)

const LEFT_MOUSE:int = 1;

export(String) var tag:String = ""

onready var a:float = modulate.a
onready var r:float = modulate.r
onready var g:float = modulate.g
onready var b:float = modulate.b


func _on_ClickableSprite_mouse_entered() -> void:
	modulate.r = 255


func _on_ClickableSprite_mouse_exited() -> void:
	modulate.a = a
	modulate.r = r
	modulate.g = g
	modulate.b = b


func _on_ClickableSprite_pressed() -> void:
	emit_signal("press_to", self)
