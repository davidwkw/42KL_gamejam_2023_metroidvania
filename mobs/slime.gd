extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player : CharacterBody2D
var chase : bool = false

@export var move_speed : float = 100.0
@onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if chase:
		player = get_node("../../Player/Player")
		var direction = (player.position - self.position).normalized()
		direction_handler(direction.x)
		if direction.x != 0:
			if anim_player.current_animation != "Death":
				anim_player.play("Move")
			self.velocity.x = move_speed * direction.x
	else:
		if anim_player.current_animation != "Death":
			anim_player.play("Idle")
		self.velocity.x = move_toward(self.velocity.x, 0, move_speed)

	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false

func direction_handler(direction : float):
	var anim_sprite : AnimatedSprite2D = $AnimatedSprite2D

	if direction > 0:
		anim_sprite.flip_h = false
	elif direction < 0:
		anim_sprite.flip_h = true
	else:
		pass

func _on_damage_hitbox_body_entered(body):
	if body.name == "Player":
		anim_player.play("Death")
		await anim_player.animation_finished
		self.queue_free()
