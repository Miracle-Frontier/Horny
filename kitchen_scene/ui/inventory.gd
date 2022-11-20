extends Control


func _ready() -> void:
	$Cancel.connect("pressed", self, "clear")


func clear() -> void:
	$Items/Item1.clear_product()
	$Items/Item2.clear_product()
	$Items/Item3.clear_product()
	pass
