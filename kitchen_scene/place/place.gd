class_name Place
extends Control

const Product = preload("res://kitchen_scene/product/product.tscn")

export(Array,String) var groups:Array = []


func can_drop_data(position: Vector2, data:Dictionary) -> bool:
	return data.has("product") 


func drop_data(position: Vector2, data:Dictionary) -> void:
	var product:Product = data["product"]
	add_to_place(product, get_global_mouse_position())


func add_to_place(node:Control, position: Vector2) -> void:
	node.set_parent(self)
	node.set_global_position(position)
