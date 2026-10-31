extends Node3D

@export var spawn_curve: Curve = null
@export var timer_length := 4.9
var enemy = preload("res://enemy/enemy.tscn")
@export var big_number = 100
var time_passed = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label3D.text = str(Cheese.gold)


func _on_enemy_spawn_timeout() -> void:
	$enemy_spawn.wait_time = timer_length
	var E_I = enemy.instantiate()
	$Path3D.add_child(E_I)
	E_I.progress = 0.0
	


func _on_timer_timeout() -> void:
	time_passed+=1
	#print(time_passed)
