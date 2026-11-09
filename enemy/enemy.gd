extends PathFollow3D

@export var enemy_type: Resource = null
@export var speed: float = 15;
@onready var base = get_tree().get_first_node_in_group("base")


func _ready() -> void:
	
	#progress = 0.0
	#enemy_type = enemy_types.pick_random()
	speed = enemy_type.speed
	$StaticBody3D.max_health = enemy_type.health*1.2
	$StaticBody3D.health = $StaticBody3D.max_health
	if get_tree().get_nodes_in_group("enemy").size()>=0:                                                                   
		for turret in get_tree().get_nodes_in_group("actual_turret"):
			if turret.turret_type!=load("res://tower_types/miner.tres"):
				#turret.shoot()
				pass



func _process(delta: float) -> void:
	move(delta)
	if progress_ratio==1.0:
		base.take_damage(1)
		queue_free()
func move(delta):
	progress+=speed*delta
