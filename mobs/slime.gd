extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
const MOVE_SPEED = 100

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		player = get_node("../Player/Player.tscn")
		print(str(player.position))
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			self.position.x += MOVE_SPEED
		elif direction.x < 0:
			self.position.x -= MOVE_SPEED


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()
