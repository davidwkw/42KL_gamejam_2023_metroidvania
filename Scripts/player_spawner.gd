extends Node2D


var player_scene = preload("res://Player/Player.tscn")
var player = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player == null:
		var respawn_player = player_scene.instantiate()
		respawn_player.position = position
		get_parent().add_child(respawn_player)
		player = respawn_player
