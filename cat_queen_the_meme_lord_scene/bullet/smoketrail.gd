extends Line2D

signal end_smoke


export(bool) var limit_life_time:bool = false
export(float) var wildness:float = 3.0
export(float) var min_spaw_distance = 0.1


var gravity:Vector2 = Vector2.LEFT
var lifetime:Array = [5.0, 5.0]
var tick_speed:float = 0.001
var tick:float = 0.0
var wild_speed:float = 0.1
var point_age:Array = [0.0]

onready var tween:Tween = $Decay


func _ready() -> void:
	clear_points()
	if limit_life_time:
		tween.interpolate_property(self,"modulate:a", 1.0, 0.0, rand_range(lifetime[0], lifetime[1]), Tween.TRANS_CIRC, Tween.EASE_OUT)
		tween.start()


func add_point(point_pos:Vector2, at_pos:int = -1) -> void:
	if get_point_count() > 0 and point_pos.distance_to(points[get_point_count()-1]) < min_spaw_distance:
		return
	point_age.append(0.0)
	.add_point(point_pos, at_pos)


func _process(delta: float) -> void:
	if tick >= tick_speed:
		tick = 0
		for p in range(get_point_count()):
			point_age[p] += 2 * delta
			var rnd_vector:Vector2 = Vector2(rand_range(-wild_speed, wild_speed), rand_range(-wild_speed, wild_speed))
			points[p] +=  20 * gravity + (rnd_vector * wildness)
	else:
		tick += delta
	add_point(position)


func _on_Decay_tween_all_completed() -> void:
	emit_signal("end_smoke")
	pass
