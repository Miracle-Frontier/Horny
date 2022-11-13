extends Node2D

const min_distance:float = 250.0
export var garbage_count:int = 2
onready var garbage_provider:Node = $GarbageProvider
onready var bound_min:Position2D = $SpawnBound/Min
onready var bound_max:Position2D = $SpawnBound/Max
onready var player:KinematicBody2D = $Player
onready var broom:Node2D = $Broom

func _ready() -> void:
	randomize()
	set_player_to_random_position()
	var garbages:Array = create_garbages()
	put_garbages_to_random_positions(garbages)	
	

func set_player_to_random_position() -> void:
	var position:Vector2 = player.global_position
	position.x = get_random_x_position()
	player.global_position = position
	player.init_broom(broom)


func create_garbages() -> Array:
	var garbages:Array = []
	 
	for i in garbage_count:
		var garbage:Node2D = garbage_provider.get_random_garbage();
		garbage.connect("need_clear", self, "clear_garbage")
		garbage.position.y = bound_min.global_position.y
		garbages.append(garbage)
	
	return garbages

func clear_garbage() -> void:
	broom.clear()


func put_garbages_to_random_positions(garbages: Array) -> void:
	for garbage in garbages:
		 put_garbages_to_random_position(garbage)
	


func put_garbages_to_random_position(garbage: Node2D) -> void:
	var player_x_pos = player.global_position.x
	
	while true:
		var pos_x:float = get_random_x_position()
		if abs(player_x_pos - pos_x) > min_distance:
			garbage.position.x = pos_x
			break
			
	call_deferred("add_child", garbage)
	 
	
func normalize_x_position(position_x: float) -> float:
	var bound:Vector2 = get_spawn_bound();
	return normalize_value(position_x, bound.x, bound.y)
	
	
func normalize_value(value:float, rangeStart:float, rangeEnd:float) -> float:
	return (value - rangeStart) / (rangeEnd - rangeStart);

	
func get_random_x_position() -> float:
	var bound:Vector2 = get_spawn_bound();
	return rand_range(bound.x, bound.y);

# мне не нравится использовать тут вектор
func get_spawn_bound() -> Vector2:
	var min_x:float  = bound_min.global_position.x
	var max_x:float = bound_max.global_position.x
	return Vector2(min_x, max_x)
