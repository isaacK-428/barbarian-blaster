extends Node
var in_upgrade = false
#func set_turret(node: Node3D):
	#for i in get_tree().get_first_node_in_group("camera"):
		#i.turret=node
