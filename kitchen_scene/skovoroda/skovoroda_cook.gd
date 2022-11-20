extends Cook

export(Dictionary) var cook_prefabs = {}

func cook(product:Product) -> Product:
	var groups:Array = product.get_groups()
	print(groups)
	for group in groups:
		if cook_prefabs.has(group):
			return _create_new(group, product)
	
	return product


func _create_new(group:String, product:Product) -> Product:
	product.queue_free()
	var new_product:Product = (cook_prefabs[group] as PackedScene).instance()
	print("created " + str(new_product))
	return new_product


func is_correct_product(product:Product) -> bool:
	var groups:Array = product.get_groups()
	for group in groups:
		if cook_prefabs.has(group):
			return true
	return false
