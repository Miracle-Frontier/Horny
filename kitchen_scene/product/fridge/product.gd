class_name Product
extends TextureRect

export(bool) var draggable:bool = true


onready var parent:Node = null
onready var selected:bool = false
onready var grab:bool = false
onready var start_rect_size:Vector2 = rect_size


func _ready() -> void:
	if texture == null:
		texture = $Sprite.texture
		$Sprite.visible = false
	pass


func _process(delta: float) -> void:
	if selected and draggable:
		follow_mouse()


func follow_mouse() -> void:
	#position = get_global_mouse_position()
	pass


func _on_Area2D_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		selected = event.pressed
		if not selected and not grab:
			#position = save_position
			pass


func get_drag_data(position: Vector2):
	var data = {}
	clear_modulate()
	data["product"] = self.duplicate() if parent == null else self #если это истоник продуктов(фабрика), то у него нет родитеской ноды
	$Modulator.modulate_on()
	var drag_texture:TextureRect = TextureRect.new()
	drag_texture. expand = true
	drag_texture.texture = texture
	drag_texture.rect_size = rect_size * 0.5
	var control = Control.new()
	control.add_child(drag_texture)
	drag_texture.rect_position = -0.5 * drag_texture.rect_size
	set_drag_preview(control)
	return data


func remove_from_parent() -> void:
	if self.parent != null:
		self.parent.remove_child(self)


func set_parent(parent: Node) -> void:
	remove_from_parent()
	parent.add_child(self)
	self.parent = parent

func _on_Product_mouse_entered() -> void:
	$Modulator.modulate_on()


func _on_Product_mouse_exited() -> void:
	clear_modulate()
	

func clear_modulate() -> void:
	$Modulator.modulate_off()
