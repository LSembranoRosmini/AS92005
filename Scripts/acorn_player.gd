extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var player_index: int = 1
@onready var animated_sprite = $AnimatedSprite2D



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

# Handle jump for separate players.
	#P1 Jump
	if player_index == 0:
		if Input.is_action_just_pressed("p1_jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
	#P2 Jump
	if player_index == 1:
		if Input.is_action_just_pressed("p2_jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

# Get the input direction and handle the movement/deceleration.
	#P1 Controls
	if player_index == 0:
		var direction := Input.get_axis("p1_left", "p1_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true


	#P2 Controls
	if player_index == 1:
		var direction := Input.get_axis("p2_left", "p2_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if direction > 0:
			animated_sprite.flip_h = true
		elif direction < 0:
			animated_sprite.flip_h = false




	move_and_slide()
