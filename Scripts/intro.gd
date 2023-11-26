extends Node2D

func _input(_event):
	if Input.is_action_just_pressed("ui_interact"):
		get_tree().change_scene_to_file("res://maps/map_0.tscn")
