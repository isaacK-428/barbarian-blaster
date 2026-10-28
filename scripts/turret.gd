extends Node3D
@export var bullet: PackedScene = null
@onready var turret_top: MeshInstance3D = $MeshInstance3D
@export var enemy_path: Path3D
var look_enemy = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if enemy_path.get_children().size()!=0:
		var enemy = enemy_path.get_children().back()
		look_enemy = enemy
		look_at(enemy.global_position,Vector3.UP,true)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func shoot():
	if enemy_path.get_children().size()!=0:
		var shot = bullet.instantiate()
		add_child(shot)
		shot.target = look_enemy
		shot.global_position = turret_top.global_position
		shot.direction = global_transform.basis.z


func _on_timer_timeout() -> void:
	shoot()
