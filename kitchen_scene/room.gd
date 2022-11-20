class_name RoomK
extends Node2D

signal cook
const Product = preload("res://kitchen_scene/product/product.tscn")
const Cook = preload("res://kitchen_scene/cook.gd")

onready var cook_node:Cook = get_node("Cook")

func _ready() -> void:
	#$CookButton.connect("pressed", self, "cook")
	$In.connect("node_added", self, "_product_added")
	pass


func is_can_add(product: Product) -> bool:
	if cook_node != null:
		return cook_node.is_correct_product(product)
	else:
		return false


func cook(product:Product):
	if cook_node != null:
		product.rect_position = Vector2.ZERO
		product.remove_from_parent()
		var cooced_product:Product = cook_node.cook(product)
		$Out.add_child(cooced_product)
	
	else:
		print("Нода в которой импелементирована логика готовки не найдена!")
	
	
func _product_added(node:Control) -> void:
	if node.is_in_group("product"):
		cook(node)
