extends Node3D
signal button_pressed
@export var index := 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func clicked():
	print("random button was clicked")
	emit_signal("button_pressed")
	button_actions(index)
func button_actions(button):
	match button:
		5:
			print(5)
func enable():
	$CollisionShape3D.disabled = false
	pass
func disable():
	$CollisionShape3D.disabled = true
