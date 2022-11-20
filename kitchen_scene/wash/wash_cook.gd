extends Cook


export(Dictionary) var washed_textures = {}

func cook(product:Product) -> Product:
	var groups:Array = product.get_groups()
	print(groups)
	for group in groups:
		if washed_textures.has(group):
			_wash(group, product)
			break
	
	return product


func _wash(group:String, product:Product) -> void:
	product.add_to_group("washed_" + group)
	product.texture = washed_textures[group]
	

func is_correct_product(product:Product) -> bool:
	var groups:Array = product.get_groups()
	print(groups)
	for group in groups:
		if washed_textures.has(group):
			return true
	return false
