extends Node2D

var scene = preload("res://dvornik_scene/dvornik_scene.tscn")

func _ready():
	var dialog = Dialogic.start("start_cutscene")
	dialog.pause_mode = Node.PAUSE_MODE_PROCESS
	dialog.connect("dialogic_signal", self, "dialog_listener")
	dialog.connect("timeline_end", self, "cutscene_ended")
	add_child(dialog)
	
func dialog_listener(name):
	var node = get_node(name)
	node.visible = !node.visible
	
func cutscene_ended(_name):
	get_parent().add_child(scene.instance())
	queue_free()
