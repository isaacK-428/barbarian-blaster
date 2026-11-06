extends Node
var in_upgrade = false
var gold: int = 10
@onready var music_player: AudioStreamPlayer = $AudioStreamPlayer

#func set_turret(node: Node3D):
	#for i in get_tree().get_first_node_in_group("camera"):
		#i.turret=node
func _process(delta: float) -> void:
	#print("gold ",gold)
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play( )
