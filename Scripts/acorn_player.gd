extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var player_index: int = 1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump for separate players.
	if player_index == 0:
		if Input.is_action_just_pressed("p1_jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
	if player_index == 1:
		if Input.is_action_just_pressed("p2_jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if player_index == 0:
		var direction := Input.get_axis("p1_left", "p1_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	if player_index == 1:
		var direction := Input.get_axis("p2_left", "p2_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
