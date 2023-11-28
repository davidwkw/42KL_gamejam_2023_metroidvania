extends Node

var bgm = load("res://assets/Music/background_music/Peritune_Black_Crystal.ogg")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_music():
	$Music.stream = bgm
	$Music.play()
