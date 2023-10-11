extends CharacterBody2D

@export var speed : float = 300.0

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : ChracterStateMachine = $ChracterStateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	direction = Input.get_vector("right", "left",  "up", "down")
	
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_animation()
	update_face_direction()


func update_animation():
	animation_tree.set("parameters/Move/blend_position", direction.x)


func update_face_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0: 
		sprite.flip_h = true
