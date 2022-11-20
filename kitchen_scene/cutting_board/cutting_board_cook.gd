extends Cook

export(Dictionary) var cut_textures = {}

func cook(product:Product) -> Product:
	var groups:Array = product.get_groups()
	print(groups)
	for group in groups:
		if cut_textures.has(group):
			_cut(group, product)
			break
	return product


func _cut(group:String, product:Product) -> void:
	product.add_to_group("cut_" + group)
	product.texture = cut_textures[group]
	
	
func is_correct_product(product:Product) -> bool:
	var groups:Array = product.get_groups()
	print(groups)
	for group in groups:
		if cut_textures.has(group):
			return true
	return false
