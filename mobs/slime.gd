extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player : CharacterBody2D
var chase : bool = false

@export var move_speed : float = 50.0
@onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if chase:
		player = get_node("../../Player/Player")
		var direction = (player.position - self.position).normalized()
		direction_handler(direction.x)
		if direction.x > 0:
			self.velocity.x += move_speed
		elif direction.x < 0:
			self.velocity.x -= move_speed
		else:
			self.velocity.x = 0
		if direction.x != 0:
			anim_player.play("Move")
		
	move_and_slide()


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false

func direction_handler(direction : int):
	var anim_sprite : AnimatedSprite2D = $AnimatedSprite2D
	
	if direction > 0:
		anim_sprite.flip_h = false
	elif direction < 0:
		anim_sprite.flip_h = true
	else: 
		pass
