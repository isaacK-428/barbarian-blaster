extends Node3D
@export var bullet: PackedScene = null
@onready var turret_top: MeshInstance3D = $MeshInstance3D
@export var enemy_path: Path3D
@export var turret_type: Resource = null
@onready var upgrades = [0,0,0]
var mini_gun = false

var current_turret: Node3D = null
var look_enemy = null
var fire_rate = 0.9
var damage = 1
var ability = 1
var miner = preload("res://tower_types/miner.tres")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer.play()
	if enemy_type!=load("res://tower_types/miner.tres"):
		$Timer2.queue_free()
	fire_rate = turret_type.fire_rate
	damage = turret_type.damage
	match turret_type.name:
		"sniper":
			$barrel/extra_stuff/sniper.show()
		"blaster":
			$barrel/extra_stuff/blaster.show()
		"miner":
			$barrel/normal.hide()
	if turret_type == load("res://tower_types/minigunner.tres"):
		$barrel/normal.hide()
		$"barrel/extra_stuff/min gun".show()
		mini_gun = true

func _physics_process(delta: float) -> void:
	if enemy_path.get_children().size()!=0:
		var enemy = get_best_target()
		look_enemy = enemy
		if enemy!=null:
			look_at(enemy.global_position,Vector3.UP,true)
			

		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func shoot():
	if current_turret!=miner:
		$AnimationPlayer.stop()
		$AnimationPlayer.play("fire")
		if enemy_path.get_children().size()!=0:
			var shot = bullet.instantiate()
			add_child(shot)
			shot.target = look_enemy
			shot.global_position = turret_top.global_position
			shot.direction = global_transform.basis.z
			shot.damage=damage
			$Timer.wait_time = fire_rate
	$Timer.start()
	


func _on_timer_timeout() -> void:
	if turret_type!=miner:
		shoot()
func apply_upgrades(fire_rate: float,DMG: float,new_ability: int):
	$Timer.wait_time = fire_rate
	damage=DMG
	ability = new_ability
	#print("damage ",damage,"  fire rate ", fire_rate," ability ",ability)
func show_select():
	$CSGBox3D.show()
func hide_select():
	$CSGBox3D.hide()
func get_best_target():
	var target: PathFollow3D = null
	var best_progress = 0
	for enemy in get_tree().get_nodes_in_group("enemy"):
		if enemy is PathFollow3D:
			if enemy.progress > best_progress:
				best_progress = enemy.progress
				target = enemy
	return target


func _on_timer_2_timeout() -> void:
	Cheese.gold+=1
	print("miner set gold")
