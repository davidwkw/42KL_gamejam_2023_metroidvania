extends AudioStreamPlayer

var bg_music = load("res://assets/Music/background music/Breezy's Castle Quest - 2 Rebirth of Darkness.wav")

func _ready():
	pass

func play_bgm():
	$Music.stream = bg_music
	$Music.play()
