extends Control
var main_menu = preload("res://UI/start_menu.tscn")
var main_scene = preload("res://scenes/main_scene.tscn")
var insults = [
	"you suck bro",
	"L-bozo",
	"DEAD, YOU ARE"
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = str(insults.pick_random())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_pressed() -> void:
	Cheese.gold = 15
	get_tree().change_scene_to_packed(main_scene)


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_packed(main_menu )
