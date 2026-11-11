extends Area3D

var direction := Vector3.FORWARD
@export var speed := 100
@export var target = null
var damage = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move(delta)
func move(delta):
	if target==null:
		queue_free()
	if target!=null:
		position += direction * speed * delta
		direction = (target.global_position - global_position).normalized()


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("enemy"):
		body.take_damage(damage)
		queue_free()


func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("rock"):
		queue_free()
