extends Node3D

@export var turret: PackedScene = null
@export var enemy_path: Path3D = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func spawn_turret(new_position: Vector3,type: Resource):
	var T_I = turret.instantiate()
	T_I.global_position = new_position
	T_I.enemy_path=enemy_path
	T_I.turret_type=type
	add_child(T_I)
