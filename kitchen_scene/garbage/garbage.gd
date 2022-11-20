extends Control

const Product = preload("res://kitchen_scene/product/product.tscn")

func can_drop_data(position: Vector2, data:Dictionary) -> bool:
	return data.has("product")


func drop_data(position: Vector2, data:Dictionary) -> void:
	var product:Product = data["product"]
	product.remove_from_parent()
	print("garbage nam-nam")
