extends Node
var in_upgrade = false
var gold: int = 15
@onready var music_player: AudioStreamPlayer = $AudioStreamPlayer

func _process(delta: float) -> void:
	#print("gold ",gold)
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play( )
