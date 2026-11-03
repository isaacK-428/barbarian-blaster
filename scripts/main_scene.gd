extends Node3D

@export var spawn_curve: Curve = null
@export var timer_length := 4.9
var enemy = preload("res://enemy/enemy.tscn")
@export var big_number = 100
var enemy_tokens = 20
var wave = 1
var time_passed = 0
var enemy_types = [
	preload("res://base_enemy.tres")	
]

#var wave_total_costs = [
	#20,30,50,90,130
#]
var wave_total_costs = [
	5,10,15
]
var enemy_costs = [
	10,
	5,
	15
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label3D.text = str(Cheese.gold)


func _on_enemy_spawn_timeout() -> void:
	print("tokens === ",enemy_tokens)
	$enemy_spawn.wait_time = timer_length
	var E_I = enemy.instantiate()
	$Path3D.add_child(E_I)
	E_I.progress = 0.0
	var index = randi_range(0,enemy_types.size()-1)
	E_I.enemy_type = enemy_types[index]
	var enemy_cost = enemy_costs[index]
	enemy_tokens-=enemy_cost
	if enemy_tokens<0:
		wave_over()
		return
	$enemy_spawn.start()
	
	


func _on_timer_timeout() -> void:
	time_passed+=1
func wave_over():
	print("wave over")
	wave+=1
	#enemy_types = wave_enemies[wave-1]
	enemy_tokens = wave_total_costs[wave-1]
	await get_tree().create_timer(1.0).timeout
	print("lets go")
	match wave:
		1:
			change_wave_values([preload("res://fast_enemy.tres")],[])
		2:
			change_wave_values([preload("res://fast_enemy.tres"),preload("res://tank_enemy.tres")],[preload("res://base_enemy.tres")])
		3:
			change_wave_values([preload("res://tank_enemy.tres")],[])
		4:
			change_wave_values([],[])
	$enemy_spawn.start()
	print("enemy types     -  - - - - - - - -         ",enemy_types)
func change_wave_values(adds: Array,subtracts: Array):
	for i in subtracts.size():
		var erase_index = 0
		for j in enemy_types.size():
			if enemy_types[j] == subtracts[i]:
				erase_index = j
		enemy_types.remove_at(erase_index)
	for i in adds.size():
		enemy_types.append(adds[i])
			
