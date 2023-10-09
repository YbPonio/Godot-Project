extends CharacterBody2D


@export var speed : float = 300.0
@export var jump_velocity : float = -400.0
@export var double_jump_velocity : float = -300.0

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jump: bool = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		has_double_jump = false

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_velocity
		elif not has_double_jump:
			velocity.y = double_jump_velocity
			has_double_jump = true
			
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("right", "left")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
