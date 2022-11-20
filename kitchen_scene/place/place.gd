extends Control

signal node_added(node)

const RoomK = preload("res://kitchen_scene/room.gd")
const Product = preload("res://kitchen_scene/product/product.tscn")

#onready var parent:Room = get_parent()


func can_drop_data(position: Vector2, data:Dictionary) -> bool:
	if not data.has("product"):
		return false
	var product:Product = data["product"]
	var parent:RoomK = get_parent()
	return parent.is_can_add(product)  


func drop_data(position: Vector2, data:Dictionary) -> void:
	var product:Product = data["product"]
	add_to_place(product, get_global_mouse_position())


func add_to_place(node:Control, position: Vector2) -> void:
	node.set_parent(self)
	node.set_global_position(position)
	emit_signal("node_added", node)
