extends Area2D


var entered = false

func _on_body_entered(_body: CharacterBody2D):
	entered = true
	print("entered")

func _on_body_exited(_body: CharacterBody2D):
	entered = false
	print("left")

func _process(_delta):
	if entered == true and Input.is_action_just_pressed("ui_interact"):
		get_tree().change_scene_to_file("res://maps/map_1.tscn")
