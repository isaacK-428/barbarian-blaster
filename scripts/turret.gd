extends Node3D
@export var bullet: PackedScene = null
@onready var turret_top: MeshInstance3D = $MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shoot()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func shoot():
	var shot = bullet.instantiate()
	add_child(shot)
	shot.global_position = turret_top.global_position


func _on_timer_timeout() -> void:
	pass # Replace with function body.
