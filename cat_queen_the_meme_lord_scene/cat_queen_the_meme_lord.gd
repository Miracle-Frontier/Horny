extends Node2D

signal reset_time

const Side = preload("res://cat_queen_the_meme_lord_scene/spear/spear_spawner.gd").Side
const Rainbow:PackedScene = preload("res://cat_queen_the_meme_lord_scene/rainbow/gate.tscn")
var cat_scene = preload("res://cat_queen_the_meme_lord_scene/cat/Cat.tscn")

onready var asteroid_spawner:Node2D = $RockSpawn
onready var gate_spawner:Node2D = $GateSpawner
onready var spear_spawner:Node2D = $SpearSpawner
onready var shake:Node = $ScreenShake
onready var progress:Node = $UI/ProgressBar

var DEBUG = false

func _ready() -> void:
	randomize()
	#get_tree().set_current_scene(self) # костыль
	$UI/ProgressBar.connect("is_over", self, "time_over")
	shake.set_camera($Camera2D)
	$Player.connect("player_contacted", self, "reset_time")

	var tween_background_alpha = create_tween()
	tween_background_alpha.set_trans(Tween.TRANS_CUBIC)
	tween_background_alpha.tween_property($ParallaxBackground/ParallaxLayer/Background, "modulate:a", 1.0, 2.5)
	if DEBUG:
		$Player/Wings.play("fly_wings")
		$Player/Wings/FlashingWings.play("flashing_wings")
		var tween:SceneTreeTween = create_tween()
		var stars1 = $Bg/Stars1
		var stars3 = $Bg/Stars3
		tween.parallel().tween_property(stars1, "modulate:a", 1.0, 2.0)
		tween.parallel().tween_property(stars3, "modulate:a", 0.0, 2.0)
		progress.start_time()
	else:
		cutscene_1()
		#progress.start_time()
		
func _test() -> void: # Здесь нельзя делать Yield, опираемся на progress bar
	create_asteroid(0, 600, 300, Vector2(2, 2), false)
	#create_asteroid(100, 300.0, Vector2(2, 2), false)
	#create_asteroid(600, 50, Vector2(2, 2), true)
	#create_asteroid(600, 30, Vector2(2, 2), false)
	#create_flappy_bird(300, 600,300, true)
	#create_flappy_bird(300, 600,900, true)
	yield(get_tree().create_timer(3), "timeout")
	#create_spear(Side.RIGHT, 200)
	#create_spear(Side.LEFT, 500)
	#create_spear(Side.UP, 200)
	#create_spear(Side.DOWN, 800)
	#shake_screen()
	pass


func value_changed_cutscene2(value):
	var scale
	var speed
	match int(value):
		54:
			var cat = cat_scene.instance()
			cat.position = Vector2(-259,450)
			add_child(cat)
		45:
			for i in range(5):
				var random_height = rand_range(100,700)
				create_flappy_bird(0-(i*700), random_height,random_height+250, 500, false)
		36:
			for i in range(3):
				create_spear(Side.LEFT, 900-(i*200))
				yield(get_tree().create_timer(0.8), "timeout")
				create_spear(Side.RIGHT, 900-((i+1)*200))
				yield(get_tree().create_timer(0.8), "timeout")
		26:
			scale = Utils.get_prob_ps([1,1.3], [[10,40,80], [41, 60, 6], [61,81,4],[81,90,4]])
				
			for i in range(30):
				if scale > 1.7:
					speed = rand_range(500,300)
				elif scale > 1.4:
					speed = rand_range(201,300)
				else:
					speed = rand_range(500,500)
				
				create_asteroid(0-int(i/3)*500, rand_range(0,900), speed, Vector2(scale, scale), false)
		
		20:
			for i in range(3):
				create_spear(Side.UP, i*200)
				yield(get_tree().create_timer(0.2), "timeout")
			for i in range(3):
				create_spear(Side.UP, 1600-i*200)
				yield(get_tree().create_timer(0.2), "timeout")
			yield(get_tree().create_timer(1.3), "timeout")
			for i in range(3):
				create_spear(Side.UP, 600+i*200)
		3:
			var tween2:SceneTreeTween = create_tween().set_trans(Tween.TRANS_CUBIC)
			tween2.tween_property($Mouse, "modulate:a", 0.0, 1.0)
		4:
			scale = Utils.get_prob_ps([1,2], [[10,40,80], [41, 60, 6], [61,81,4],[81,90,4]])
				
			for i in range(30):
				if scale > 1.7:
					speed = rand_range(200,500)
				elif scale > 1.4:
					speed = rand_range(301,500)
				else:
					speed = rand_range(400,660)
				
				create_asteroid(0-int(i/3)*500, rand_range(0,900), speed, Vector2(scale, scale), false)
var first39 = true

var cutscene2_completed = false

func _on_ProgressBar_value_changed(value):
	print(value)
	if cutscene2_completed:
		value_changed_cutscene2(value)
		return
	
	match int(value):
		57:
			cutscene_2()
		40:
			create_asteroid(0,200, 500.0, Vector2(1, 1), true)
		45:	
			create_asteroid(0,500, 350.0, Vector2(1.4, 1.4), true)
			#create_asteroid(600, 50, Vector2(2, 2), true)
		
		39:
			create_spear(Side.LEFT, 700)
			if first39:
				first39 = false
				var dialog = Dialogic.start("main_says_4")
				add_child(dialog)	
		25:
			for i in range(40):
				if (i>20):
					create_flappy_bird(1900+(i*200), 600+((20-i)*10), 850+((20-i)*10),800, true)
				else:
					create_flappy_bird(1900+(i*200), 600, 850,800, true)
				
		18:
			for i in range(38):
				create_flappy_bird(1900+(i*200), 0+(i*10), 900-(i*10),1300, true)
		2:
			create_flappy_bird(1900, 600, 800,500, true)
		7:	
			create_flappy_bird(1900, 300, 500,600, true)
			create_flappy_bird(1900+200+400+200, 100, 300,600, true)
			create_flappy_bird(1900+200+800+200, 200, 400,600, true)
			create_flappy_bird(1900+200+1600+200, 300, 500,600, true)
			create_flappy_bird(1900+200+2000+200, 400, 600,600, true)
			create_flappy_bird(1900+200+2400+200, 500, 700,600, true)
			create_flappy_bird(1900+200+2800+200, 600, 800,600, true)
			#create_flappy_bird(1900+200+3200, 700, 600,600, true)
			#for i in range(10):
			#	create_flappy_bird(1900+(i*200), 200, 400,800, true)


func _process(delta):
	#print(get_global_mouse_position())
	pass

func cutscene_2():
	$Upgrade/UpgradeWings.play("Upgrade")
	stop_animation = false
	var dialog = Dialogic.start("main_says_5")
	dialog.pause_mode = Node.PAUSE_MODE_PROCESS
	dialog.connect("dialogic_signal", self, "cutscene_2_continue")
	add_child(dialog)

func cutscene_2_continue(name):
	stop_animation = true
	$Player.fake_fire = true
	yield(get_tree().create_timer(2), "timeout")
	$Player.fake_fire = false
	cutscene2_completed = true


	$Player.bullets_are_enabled = true
	yield(get_tree().create_timer(8), "timeout")
	_inverse_stars()
	yield(get_tree().create_timer(3.5), "timeout")	
	var tween:SceneTreeTween = create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($Mouse, "modulate:a", 1.0, 1.0)
	
	progress.stop_time()
	progress.start_time()
	
func cutscene_1():
	$Player.controls_blocked = true
	var current_tween = create_tween()
	current_tween.tween_property($Player, "position:y", 500.0, 26.5)	
	yield(get_tree().create_timer(3), "timeout")
	$Camera2D.current = true
	var dialog = Dialogic.start("main_says")
	#dialog.pause_mode = Node.PAUSE_MODE_PROCESS
	dialog.connect("timeline_end", self, "upgrade_wings")
	add_child(dialog)

func upgrade_wings(name): # Добавить звук
	$Upgrade/UpgradeWings.play("Upgrade")
	var dialog = Dialogic.start("main_says_2")
	#dialog.pause_mode = Node.PAUSE_MODE_PROCESS
	dialog.connect("timeline_end", self, "upgrade_wings2")
	add_child(dialog)

func finish_upgrade_loop():
	if stop_animation:
		$Upgrade/UpgradeWings.stop()

var stop_animation = false

func stop_upgrade_animation():
	stop_animation = true
	
	var current_tween = create_tween()
	current_tween.set_trans(Tween.TRANS_CUBIC)
	current_tween.tween_property($Camera2D, "zoom:x", 0.75, 2)
	print("started tweening zoom (2 sex)")
	var current_tween2 = create_tween()
	current_tween2.set_trans(Tween.TRANS_CUBIC)
	current_tween2.tween_property($Camera2D, "zoom:y", 0.75, 2)
	
	$Player/Wings.play("show_wings")
	yield($Player/Wings, "animation_finished")
	$Player/GrowWings.modulate.a = 0
	$Player/Wings.play("fly_wings")
	$Player/Wings/FlashingWings.play("flashing_wings")
	upgrade_wings3()
	
func upgrade_wings2(name):
	stop_upgrade_animation()

func upgrade_wings3():

	var dialog = Dialogic.start("main_says_3")
	#dialog.pause_mode = Node.PAUSE_MODE_PROCESS
	dialog.connect("timeline_end", self, "upgrade_wings4")
	add_child(dialog)
	var stars1 = $Bg/Stars1
	var stars3 = $Bg/Stars1
	
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(stars1, "modulate:a", 0.0, 2.0)
	tween.tween_property(stars3, "modulate:a", 1.0, 2.0)
	
func upgrade_wings4(name):
	$Player.controls_blocked = false
	var current_tween = create_tween()
	current_tween.set_trans(Tween.TRANS_CUBIC)
	print("tweeny")
	current_tween.tween_property($Camera2D, "zoom:x", 1.0, 1)
	var current_tween2 = create_tween()
	current_tween2.set_trans(Tween.TRANS_CUBIC)
	current_tween2.tween_property($Camera2D, "zoom:y", 1.0, 1)
	progress.start_time()

var stop_all = false

func create_asteroid(pos_x:float, y_position:float, speed:float, scale:Vector2, inverse:bool) -> void:
	if not stop_all:
		asteroid_spawner.create_rock(pos_x,y_position, speed, scale, inverse)

func create_flappy_bird(pos_x: float, up_y: float, low_y: float, speed: float, inverse: float) -> void:
	if not stop_all: gate_spawner.create_gate(pos_x, up_y, low_y, speed, inverse)


func create_spear(var side:int, position:float) -> void:
	if not stop_all: spear_spawner.create_spear(side, position)


func shake_screen() -> void:
	shake.apply_shake()

var is_resetting = false

func reset_time() -> void:
	if is_resetting:
		return
	is_resetting = true
	shake_screen()
	progress.stop_time()
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_CUBIC)
	
	var to_destroy_list = []
	
	for member in get_tree().get_nodes_in_group("free"):
		tween.tween_property(member, "modulate:a", 0.0, 2.0)
		member.remove_from_group("free")
		member.remove_from_group("damage")
		to_destroy_list.append(member)
	yield(get_tree().create_timer(2.5), "timeout")	
	for member in to_destroy_list:
		if is_instance_valid(member):
			member.queue_free()
	

	progress.start_time()
	yield(get_tree().create_timer(2), "timeout")
	is_resetting = false

func time_over() -> void:
	#print("time is over = inverse")
	#reset_time()
	#_inverse_stars()
	pass
	
func _inverse_stars() -> void:
	print("INVERSE")
	var stars1:CPUParticles2D = $Bg/Stars1 #if $Bg/Stars1.modulate.a == 1.0 else $Bg/Stars2
	var stars2:CPUParticles2D = $Bg/Stars2 #if $Bg/Stars2.modulate.a == 0.0 else $Bg/Stars1
	
	var tween:SceneTreeTween = create_tween()
	tween.parallel().tween_property(stars1, "modulate:a", 0.0, 2.0)
	#tween.parallel().tween_property(stars1, "initial_velocity", 0.0, 2.0)
	#tween.parallel().tween_property(stars1, "modulate:a", 0.0, 2.0)
	#tween.parallel().tween_property(stars2, "initial_velocity", 500.0, 2.0)
	tween.parallel().tween_property(stars2, "modulate:a", 1.0, 2.0)
	yield(get_tree().create_timer(3), "timeout")
