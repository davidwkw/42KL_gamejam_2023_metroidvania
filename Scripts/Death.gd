extends Area2D


var entered = false

func _on_body_entered(_body: CharacterBody2D):
	entered = true
	print("death")
	get_tree().change_scene_to_file("res://maps/map_0.tscn")

