extends Node2D

var player_scene = preload("res://player/player.tscn")

func _ready():
	if get_node_or_null("player") == null:
		var respawn_player = player_scene.instantiate()
		respawn_player.position = position
		get_parent().add_child.call_deferred(respawn_player)
