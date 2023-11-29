extends CharacterBody2D

var starting_position : Vector2
const SPEED : float = 300.0
const JUMP_VELOCITY : float = -400.0
var is_attacking = false;
#var sound_queue : Node
var attack_sound_reference : AudioStreamPlayer
var health : int = 10

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

func _ready():
	anim_player.play("Idle")
#	sound_queue = $SoundQueue
	attack_sound_reference = $AttackSoundStream
	starting_position = position
	
func respawn():
	position = starting_position
	
func _on_Character_body_entered(body):
	if body.name == "RespawnBlock":
		respawn()
		
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 0 and is_attacking == false:
			anim_player.play("Fall")

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and is_attacking == false:
		velocity.y = JUMP_VELOCITY
		anim_player.play("Jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	direction_handler(direction)

	if direction and is_attacking == false:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim_player.play("Run")

	else:
		if is_attacking == false:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if velocity.y == 0:
				anim_player.play("Idle")
	
	if is_attacking == false and Input.is_action_just_pressed("Attack"):
		anim_player.play("Attack");
#		sound_queue.play_sound()
		attack_sound_reference.play()
		$AttackCollision/CollisionShape2D.disabled = false;
		is_attacking = true;
		if is_on_floor():
			velocity.x = 0;
	
	if is_on_floor() && is_attacking:
		velocity.x = 0;
	
	move_and_slide()
	
func direction_handler(direction : int):
	var anim_sprite : AnimatedSprite2D = get_node("AnimatedSprite2D")
	
	if direction > 0:
		anim_sprite.flip_h = false
		$AttackCollision.scale.x = 1;
	elif direction < 0:
		anim_sprite.flip_h = true
		$AttackCollision.scale.x = -1;
	else: 
		pass

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Attack":
		anim_player.play("Idle");
		$AttackCollision/CollisionShape2D.disabled = true;
		is_attacking = false;
		if not is_on_floor():
			anim_player.play("Fall")
