extends Node2D

const FADE_TIME:float = 0.5

onready var kitchen:Node = $Self
onready var current_room:Node = kitchen
onready var inventory:Control = $Control/Inventory
onready var leave_button:TextureButton = $Control/Leave

var fade_action:bool = false

onready var rooms:Dictionary = {
		$Self/Plate: kitchen,
		$Self/Fridge: $Rooms/Fridge,
		$Self/Saltpepperketchup: kitchen,
		$Self/Pot: $Rooms/Pot,
		$Self/Skovoroda: $Rooms/Skovoroda,
		$Self/Wash: $Rooms/Wash,
}

func _ready() -> void:
	leave_button.visible = false
	$Self/Plate.connect("press_to", self, "press_to")
	$Self/Fridge.connect("press_to", self, "press_to")
	$Self/Saltpepperketchup.connect("press_to", self, "press_to")
	$Self/Pot.connect("press_to", self, "press_to")
	$Self/Skovoroda.connect("press_to", self, "press_to")
	$Self/Wash.connect("press_to", self, "press_to")
	leave_button.connect("pressed", self, "leave")
	
	for room in $Rooms.get_children():
		room.modulate.a = 0
	

func press_to(node:Node) -> void:
	var room:Node = rooms[node]
	if room == kitchen:
		return
	_open_room(room)


func _close_current_room() -> void:
	var current = current_room
	var tween:SceneTreeTween = current_room.create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(current_room, "modulate:a", 0.0, FADE_TIME)
	yield(tween, "finished")
	current.visible = false


func _open_room(room:Node2D) -> void:
	if fade_action:
		return
	fade_action = true
	leave_button.visible = false
	_close_current_room()
	room.visible = true
	current_room = room
	var tween:SceneTreeTween = room.create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(room, "modulate:a", 1.0, FADE_TIME)
	yield(tween, "finished")
	#update_control_inventory(room)
	leave_button.visible = true if room != kitchen else false
	fade_action = false
	
	
func update_control_inventory(room:Node2D) -> void:
	if room == kitchen:
		$Control.add_child(inventory)
	else:
		room.get_node("Control").add_child(inventory)	
	

func leave() -> void:
	if fade_action or current_room == kitchen:
		return
	_open_room(kitchen)
