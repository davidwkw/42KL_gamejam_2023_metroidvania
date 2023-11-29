extends Node

var bgm = preload("res://assets/sounds/background_music/Peritune_Black_Crystal.ogg")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_bg_music() -> void:
	$Music.stream = bgm
	$Music.volume_db = -20
	$Music.play()
