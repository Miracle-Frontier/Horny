extends Node2D

const Product = preload("res://kitchen_scene/product/product.tscn")


func _ready() -> void:
	if true:
		return
	$Product.connect("press_to", self, "press_to")
	$Product2.connect("press_to", self, "press_to")
	$Product3.connect("press_to", self, "press_to")
	$Product4.connect("press_to", self, "press_to")
	$Product5.connect("press_to", self, "press_to")
	$Product6.connect("press_to", self, "press_to")
	$Product7.connect("press_to", self, "press_to")
	$Product8.connect("press_to", self, "press_to")
	$Product9.connect("press_to", self, "press_to")
	$Product10.connect("press_to", self, "press_to")


func press_to(node: Product) -> void:
	var dublicate_node:Node2D = node.duplicate()
	add_child(dublicate_node)
