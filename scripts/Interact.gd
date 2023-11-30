extends Area2D

var entered = false

func _on_body_entered(body: CharacterBody2D):
	if body.name == "Player":
		entered = true

func _on_body_exited(body: CharacterBody2D):
	if body.name == "Player":
		entered = false

func _process(_delta):
	if entered == true and Input.is_action_just_pressed("ui_interact"):
		get_tree().change_scene_to_file("res://cutscenes/memory_fragments.tscn")
