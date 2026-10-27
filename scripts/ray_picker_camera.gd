extends Camera3D

@export var grid_map: GridMap = null

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@export var turret_manager: Node3D = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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
				print(cell)
				if grid_map.get_cell_item(cell)==0:
					grid_map.set_cell_item(cell,1)
					var tile_map_position = grid_map.map_to_local(cell)
					turret_manager.spawn_turret(tile_map_position)
		else:
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
			
	prints("collider  ",ray_cast_3d.get_collider(),"point ",ray_cast_3d.get_collision_point())
								  
