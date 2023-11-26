extends Node2D

func _input(event):
	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_F:
		get_tree().change_scene_to_file("res://maps/map_0.tscn")
