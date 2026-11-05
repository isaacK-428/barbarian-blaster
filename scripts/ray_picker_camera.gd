extends Camera3D

@export var grid_map: GridMap = null
@export var turret_type: Resource = null
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@export var turret_manager: Node3D = null
var current_turret: Node3D = null
var fire_rate = null
var damage = null
var ability = null
var upgrade_gold_costs = [
	[0,5,10,25],
	[0,5,20,35],
	[0,5,15,30]
]
var actual_upgrades = [
	[[0.2,0.2,0.2],  #base tower
	[1,1,1],
	[1,1,1],]
	,
	[[0.2,0.2,0.2],      #blaster
	[1,1,1],
	[1,1,1],]
	,
	[[0.2,0.2,0.2],    #miner
	[1,1,1],
	[1,1,1],]
	,
	[[0.2,0.2,0.2],     #mini gunner
	[1,1,1],
	[1,1,1],]
	,
	[[0.2,0.2,0.2],    #sniper
	[1,1,1], 
	[1,1,1],]
	,
]
var turret_gold_costs = [
	15,30,15,35,20
]
var selected_turret
var turret_types = [
	preload("res://tower_types/base_tower.tres"),
	preload("res://tower_types/blaster.tres"),
	preload("res://tower_types/miner.tres"),
	preload("res://tower_types/minigunner.tres"),
	preload("res://tower_types/sniper.tres")
]
var new_turret: Resource = turret_types[0]
var turret_resource = null
@onready var upgrade_panels = [
	$up_grade_UI/button2/upgrade_panel_thing,$up_grade_UI/button/upgrade_panel_thing2,$up_grade_UI/button3/upgrade_panel_thing3
]


@onready var upgrades = [0,0,0]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_tree().get_nodes_in_group("button"):
		if i.index>=4:
			i.enable()
	#hide_upgrade_UI()
	for i in get_tree().get_nodes_in_group("button"):
		pass
		#i.connect("button_pressed",button_actions)
		i.connect("button_pressed",  button_actions.bind( i.index))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse = get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mouse)
	ray_cast_3d.force_raycast_update()
	if ray_cast_3d.is_colliding():
		var collider = ray_cast_3d.get_collider()
		if collider is GridMap:
			Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
			if Input.is_action_pressed("mouse_click"):
				var gold_cost = 67
				gold_cost = new_turret.gold_cost 
				if Cheese.gold>=gold_cost:
					var collission_point = ray_cast_3d.get_collision_point() 
					var cell = grid_map.local_to_map(collission_point )
					if grid_map.get_cell_item(cell)==0:
						grid_map.set_cell_item(cell,1)
						var tile_map_position = grid_map.map_to_local(cell)
						turret_manager.spawn_turret(tile_map_position,new_turret)
						Cheese.gold-=gold_cost
		else:
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		if collider.is_in_group("turret") and Input.is_action_just_pressed("mouse_click") and Cheese.in_upgrade==false:
			print("this is a turret")
			set_turret(collider)
			
			show_upgrade_UI()
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		if collider.is_in_group("button") and Input.is_action_just_pressed("mouse_click"):
			collider.clicked()
			
								  
func show_upgrade_UI():
	$up_grade_UI.position = Vector3(0,0,0)
	$up_grade_UI.show()
	for i in get_tree().get_nodes_in_group("button"):
		i.enable()
func hide_upgrade_UI(): 
	if current_turret!=null:
		current_turret.get_parent().show_select()
		$up_grade_UI.position = Vector3(1000,5000,7000)
		for i in get_tree().get_nodes_in_group("button"):
			i.enable()
		$up_grade_UI.hide()
		current_turret.get_parent().upgrades = upgrades
		current_turret.get_parent().hide_select()
func button_actions(button):
	#if you clikcon this before you clikc on any  turret instances are created it crashes
	var resource_index = null
	if current_turret!=null:
		for i in turret_types.size():
			if turret_types[i] == current_turret.get_parent().turret_type:
				turret_resource = current_turret.get_parent().turret_type
				resource_index = i
	match button:
		1:
			if upgrades[0] <= 2 and Cheese.gold >= upgrade_gold_costs[0][upgrades[0] + 1]:
				var cost = upgrade_gold_costs[0][upgrades[0] + 1]
				fire_rate-=actual_upgrades[resource_index][0][upgrades[0]]
				#fire_rate -= 0.2 
				upgrades[0] += 1
				Cheese.gold -= cost
		2:
			if upgrades[1] <= 2 and Cheese.gold >= upgrade_gold_costs[1][upgrades[1] + 1]:
				var cost = upgrade_gold_costs[1][upgrades[1] + 1]
				damage+=actual_upgrades[resource_index][1][upgrades[1]]
				#damage += 1
				upgrades[1] += 1
				Cheese.gold -= cost
		3:
			if upgrades[2] <= 2 and Cheese.gold >= upgrade_gold_costs[2][upgrades[2] + 1]: 
				var cost = upgrade_gold_costs[2][upgrades[2] + 1]
				ability+=actual_upgrades[resource_index][2][upgrades[2]]
				#ability += 1
				upgrades[2] += 1
				Cheese.gold -= cost
		4:
			print("4") #exit top right
			hide_upgrade_UI()
			Cheese.in_upgrade = false
		5:
			print("base")
			new_turret = turret_types[0]
		6:
			print("sniper")
			new_turret = turret_types[4]
		7:
			print("minigunner")
			new_turret = turret_types[3]
		8:
			print("blaster")
			new_turret = turret_types[2]
		9:
			print("miner")
			new_turret = turret_types[1]

			
	if button <= 4:
		$up_grade_UI/button2/Label3D2.text = str(fire_rate)
		$up_grade_UI/button/Label3D.text = str(damage)
		$up_grade_UI/button3/Label3D3.text = str(ability)
		print(fire_rate)
		print(current_turret)
		current_turret.get_parent().apply_upgrades(fire_rate, damage, ability)
		
		# Fixed loop: use range() and correct index offsetting
		for i in range(upgrade_panels.size()):
			upgrade_panels[i].change_value(upgrades[i])

func set_turret(collider):
	collider.get_parent().show_select()
	
	upgrades = collider.get_parent().upgrades
	
	upgrade_panels[0].change_value(upgrades[0])
	
	upgrade_panels[1].change_value(upgrades[1])
	
	upgrade_panels[2].change_value(upgrades[2])
	
	
	
	
	Cheese.in_upgrade = true
	current_turret=collider
	damage = current_turret.get_parent().damage
	fire_rate = current_turret.get_parent().fire_rate
	ability = current_turret.get_parent().ability
	print("ability   ",current_turret.get_parent().ability)
	$up_grade_UI/button2/Label3D2.text = str(fire_rate)
	$up_grade_UI/button/Label3D.text = str(damage)
	$up_grade_UI/button3/Label3D3	.text = str(ability)
		
