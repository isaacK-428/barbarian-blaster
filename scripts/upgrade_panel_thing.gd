extends Node3D
@export var value := 0

@onready var layers = [$MeshInstance3D3,$MeshInstance3D,$MeshInstance3D2
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func change_value(new_value):
	for i in layers:
		i.hide()
	for i in new_value:
		layers[i].show()
