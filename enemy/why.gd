extends StaticBody3D

var health = 5
var max_health = 5
var enemy_type = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func take_damage(amount):
	print("enemy took damage")
	health-=amount
	$"../Label3D".text = str(max_health)+"/"+str(health)
	if health<=0:
		die()
	print("new health ",health,"amount ",amount)
func die():
	print("die")
	Cheese.gold+=get_parent().enemy_type.gold
	get_parent().queue_free()
	
