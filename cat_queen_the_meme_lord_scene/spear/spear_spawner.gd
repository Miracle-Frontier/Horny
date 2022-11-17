extends Node2D

const Spear:PackedScene = preload("res://cat_queen_the_meme_lord_scene/spear/spear.tscn")
const Warning:PackedScene = preload("res://cat_queen_the_meme_lord_scene/spear/warning.tscn")

var degrees_map:Dictionary = {Side.UP: -90, Side.DOWN: 90, Side.LEFT: 180, Side.RIGHT: 0}
var direction_map:Dictionary = {Side.UP: Vector2(0, -1), Side.DOWN: Vector2(0, 1), Side.LEFT: Vector2(-1, 0), Side.RIGHT: Vector2(1, 0)}
var position_map:Dictionary = {Side.UP: Vector2(0, 900), Side.DOWN: Vector2(0, 0), Side.LEFT: Vector2(1600, 0), Side.RIGHT: Vector2(0, 0)}

enum Side { UP, DOWN, LEFT, RIGHT }


func create_spear(var side:int, position_vlue:float) -> void:
	var warning:Node2D = _create_warning(side, position_vlue)
	yield(get_tree().create_timer(0.5), "timeout")
	warning.queue_free()
	_create_spear(side, position_vlue)


func _create_warning(var side:int, position_value:float) -> Node2D:
	var warning:Node2D = Warning.instance()
	get_parent().add_child(warning)
	warning.rotation_degrees = degrees_map[side]
	warning.global_position = _create_position(side, position_value)
	return warning


func _create_spear(var side:int, position_value:float) -> void:
	var spear:Node2D = Spear.instance()
	get_parent().add_child(spear)
	spear.rotation_degrees = degrees_map[side]
	spear.global_position = _create_position(side, position_value)
	spear.global_position = self.global_position
	spear.set_direction(direction_map[side])
	#spear.queue_free()


func _create_position(side:int, position_value:float) -> Vector2:
	var new_positon:Vector2 = position_map[side]
	match side:
		Side.UP, Side.DOWN:
			new_positon.x = position_value
		Side.LEFT, Side.RIGHT:
			new_positon.y = position_value
	return new_positon
