extends TextureButton


func get_drag_data(position: Vector2):
	var data = {}
	var data_texture
	set_drag_preview(data_texture)
	return data


func can_drop_data(position: Vector2, data) -> bool:
	return true


func drop_data(position: Vector2, data) -> void:
	pass
