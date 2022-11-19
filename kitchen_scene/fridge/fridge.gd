extends Node2D

var positions:Dictionary = {}


func _ready() -> void:
	$Product.connect("drag_start", self, "drag_start")
	$Product2.connect("drag_start", self, "drag_start")
	$Product3.connect("drag_start", self, "drag_start")
	$Product4.connect("drag_start", self, "drag_start")
	$Product5.connect("drag_start", self, "drag_start")
	$Product6.connect("drag_start", self, "drag_start")
	$Product7.connect("drag_start", self, "drag_start")
	$Product8.connect("drag_start", self, "drag_start")
	$Product9.connect("drag_start", self, "drag_start")
	$Product10.connect("drag_start", self, "drag_start")


func drag_start(node: Node2D) -> void:
	var dublicate_node:Node2D = node.duplicate()
	add_child(dublicate_node)
