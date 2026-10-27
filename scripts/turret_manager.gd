extends Node3D

@export var turret: PackedScene = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var T_I = turret.instantiate()
	add_child(T_I)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func spawn_turret(position: Vector3):
	var T_I = turret.instantiate()
	T_I.global_position = position
	add_child(T_I)
