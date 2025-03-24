extends RigidBody2D

@onready var animated_sprite_2d = $AnimatedSprite2
@onready var raycast = $RayCast2D

const MOVE_SPEED = 50
const MAX_SPEED = 100
const JUMP_FORCE = -300

func _physics_process(delta):
	var direction = Input.get_axis("p1_left", "p1_right")
	var force = Vector2.ZERO
	
	if direction:
		force.x = MOVE_SPEED * direction
		if abs(linear_velocity) > MAX_SPEED: linear_velocity.x = MAX_SPEED * direction
	
	apply_central_force(force)
	
	
	
