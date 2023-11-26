extends CharacterBody2D

var starting_position
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var isAttacking = false;

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

func _ready():
	anim_player.play("Idle")

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
		if velocity.y > 0 and isAttacking == false:
			anim_player.play("Fall")

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and isAttacking == false:
		velocity.y = JUMP_VELOCITY
		anim_player.play("Jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	direction_handler(direction)

	if direction and isAttacking == false:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim_player.play("Run")

	else:
		if isAttacking == false:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if velocity.y == 0:
				anim_player.play("Idle")
	
	if isAttacking == false and Input.is_action_just_pressed("Attack"):
		anim_player.play("Attack");
		$AttackCollision/CollisionShape2D.disabled = false;
		isAttacking = true;
		if is_on_floor():
			velocity.x = 0;
	
	if is_on_floor() && isAttacking:
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
		isAttacking = false;
		if not is_on_floor():
			anim_player.play("Fall")
