extends Node3D
@onready var label: Label3D = $Label3D

@export var max_health: int = 2
var current_health = 5:
	set(new_health):
		current_health = new_health
		var red = Color.RED
		var white = Color.WHITE
		var C = red.lerp(white,(float(current_health)/float(max_health)))
		$Label3D.modulate  = red.lerp(white,(float(current_health)/float(max_health)))
		$Label3D.text = str(new_health)+"/" + str(max_health)
		if new_health<=0:
			die()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health=max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
func take_damage(amount):
	current_health-=amount
	$AudioStreamPlayer.play()
func die():
	get_tree().change_scene_to_file("res://UI/you_died.tscn")
