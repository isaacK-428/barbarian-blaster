extends Node
var in_upgrade = false
var gold: int = 20000
#func set_turret(node: Node3D):
	#for i in get_tree().get_first_node_in_group("camera"):
		#i.turret=node
func _process(delta: float) -> void:
	#print("gold ",gold)
	pass
