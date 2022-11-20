extends TextureButton

const Product = preload("res://kitchen_scene/product/product.tscn")

var product:Product

onready var icon:TextureRect = $Icon

func put(product:Product) -> void:
	remove()
	self.product = product
	add_child(product)

	
func remove() -> void:
	if product == null:
		return
	product.queue_free()
	product = null


func get_drag_data(position: Vector2):
	var data = {}
	if product == null:
		return data
	data["product"] = product
	var drag_texture:TextureRect = TextureRect.new()
	drag_texture. expand =true
	drag_texture.texture = product.texture
	drag_texture.rect_size = product.rect_size * 0.5
	var control = Control.new()
	control.add_child(drag_texture)
	drag_texture.rect_position = -0.5 * drag_texture.rect_size
	set_drag_preview(control)
	clear_product()
	return data


func clear_product() -> void:
	product = null
	icon.texture = null


func can_drop_data(position: Vector2, data:Dictionary) -> bool:
	return data.has("product")


func drop_data(position: Vector2, data:Dictionary) -> void:
	product = data["product"]
	icon.texture = product.texture
	product.set_parent(self)
	product.set_position(Vector2(-1000,-1000))


func remove_child(node:Node) -> void:
	if node == product:
		clear_product()
	else:
		.remove_child(node)	
