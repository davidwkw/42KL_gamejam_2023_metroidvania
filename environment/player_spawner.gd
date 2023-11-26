extends Node2D


var player_scene = preload("res://player/Player.tscn")
var player = null

func _process(_delta):
	if player == null:
		var new_player = player_scene.instantiate()
		new_player.position = position
		get_parent().add_child(new_player)
		player = new_player
