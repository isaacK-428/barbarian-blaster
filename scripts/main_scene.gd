extends Node3D

@export var spawn_curve: Curve = null
@export var timer_length := 4.9
var enemy = preload("res://enemy/enemy.tscn")
@export var big_number = 100
var enemy_tokens = 20
var wave = 1
var wait = false
var time_passed = 0
var enemy_types = [
	preload("res://base_enemy.tres")	
]

#var wave_total_costs = [
	#20,30,50,90,130
#]
var wave_total_costs = [
	7,10,15,40,100,130,140,400,500
]
var all_enemys = [
	preload("res://base_enemy.tres"),
	preload("res://fast_enemy.tres"),
	preload("res://tank_enemy.tres"),
	preload("res://tank2.tres"),
	preload("res://boss_enemy.tres"),
	preload("res://demon_enemy.tres"),
	preload("res://demon_2_enemy.tres"),
	preload("res://the_final_man.tres")
]
var enemy_costs = [
	10,
	5,
	15,
	25,
	40,
	45,
	60,
	100,
	100
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(5.0).timeout
	#Engine.time_scale = 3.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(wait)
	$Label3D.text = str(Cheese.gold)
	if wait == true:
		print(get_tree().get_nodes_in_group("enemy"))
		if get_tree().get_nodes_in_group("enemy").size()<=0:
			get_tree().change_scene_to_file("res://UI/You_win.tscn")


func _on_enemy_spawn_timeout() -> void:
	if enemy_types.size()>0:
		$enemy_spawn.wait_time = timer_length
		var E_I = enemy.instantiate()    
		E_I.progress = 0.0
		var index = randi_range(0,enemy_types.size()-1)
		var new_index = all_enemys.find(enemy_types[index])
		
		E_I.enemy_type = enemy_types[index]
		$Path3D.add_child(E_I) 
		var enemy_cost = enemy_costs[new_index]
		enemy_tokens-=enemy_cost
		if enemy_tokens<0:
			wave_over()
			return
		$enemy_spawn.start()
	
	


func _on_timer_timeout() -> void:
	time_passed+=1
func wave_over():
	wave+=1
	#enemy_types = wave_enemies[wave-1]
	enemy_tokens = wave_total_costs[wave-1]
	await get_tree().create_timer(1.0).timeout
	match wave:
		1:
			change_wave_values([preload("res://fast_enemy.tres"),preload("res://fast_enemy.tres")],[])
		2:
			change_wave_values([preload("res://tank_enemy.tres"),preload("res://tank_enemy.tres")],[preload("res://fast_enemy.tres")])
		3:
			change_wave_values([preload("res://tank_enemy.tres"),preload("res://boss_enemy.tres")],[preload("res://fast_enemy.tres"),preload("res://fast_enemy.tres")])
		4:
			change_wave_values([preload("res://boss_enemy.tres"),preload("res://fast_enemy.tres"),preload("res://boss_enemy.tres"),preload("res://tank2.tres")],[preload("res://tank_enemy.tres")])
		5:
			change_wave_values([preload("res://demon_enemy.tres")],[preload("res://boss_enemy.tres"),preload("res://base_enemy.tres")])
		6:
			change_wave_values([preload("res://demon_enemy.tres")],[preload("res://fast_enemy.tres")])
		7:
			enemy_types = [preload("res://the_final_man.tres")]
		8:
			pass
			
		9:
			wait = true
			enemy_types = []
			get_tree().change_scene_to_file("res://UI/You_win.tscn")
		10:
			pass
		11:
			pass
	$enemy_spawn.start()
func change_wave_values(adds: Array,subtracts: Array):
	for i in subtracts.size():
		var erase_index = 0
		for j in enemy_types.size():
			if enemy_types[j] == subtracts[i]:
				erase_index = j
		enemy_types.remove_at(erase_index)
	for i in adds.size():
		enemy_types.append(adds[i])
			
