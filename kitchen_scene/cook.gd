class_name Cook
extends Node

const Product = preload("res://kitchen_scene/product/product.tscn")

func cook(product:Product) -> Product:
	return product


func is_correct_product(product:Product) -> bool:
	return false
