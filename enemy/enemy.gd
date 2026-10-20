extends PathFollow3D


@export var speed: float = 15
@onready var base = get_tree().get_first_node_in_group("base")
func _ready() -> void:
	#progress = 0.0
	こんにちは()



func _process(delta: float) -> void:
	move(delta)
	if progress_ratio==1.0:
		base.take_damage(1)
		queue_free()
func move(delta):
	progress+=speed*delta
func こんにちは():
	print("oh my gosh")
