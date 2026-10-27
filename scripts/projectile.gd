extends Area3D

var direction := Vector3.FORWARD
@export var speed := 40
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move(delta)
func move(delta):
	position += direction * speed * delta
