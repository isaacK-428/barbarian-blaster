extends Camera3D

@export var grid_map: GridMap = null

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@export var turret_manager: Node3D = null
var current_turret: Node3D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
				var collission_point = ray_cast_3d.get_collision_point() 
				var cell = grid_map.local_to_map(collission_point )
				if grid_map.get_cell_item(cell)==0:
					grid_map.set_cell_item(cell,1)
					var tile_map_position = grid_map.map_to_local(cell)
					turret_manager.spawn_turret(tile_map_position)
		else:
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		if collider.is_in_group("turret") and Input.is_action_just_pressed("mouse_click") and Cheese.in_upgrade==false:
			print("this is a turret")
			Cheese.in_upgrade = true
			current_turret=collider
			show_upgrade_UI()
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		if collider.is_in_group("button"):
			collider.clicked()
			
								  
func show_upgrade_UI():
	$up_grade_UI.show()
func hide_upgrade_UI():
	$up_grade_UI.hide()
func button_actions(button):
	match button:
		1:
			print("1")
		2:
			print("2")
		3:
			print("3")
		4:
			print("4")
