extends CharacterBody2D


@export var SPEED = 250.0
@export var JUMP_VELOCITY = -300.0

@onready var animated_sprite = $AnimatedSprite2D
@onready var audio_fire = $AudioFire
@onready var audio_ice = $AudioIce

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var element = "nature"

func _ready():
	animated_sprite.material.set_shader_parameter("fire", false)
	animated_sprite.material.set_shader_parameter("ice", false)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		animated_sprite.play("jump")

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction < 0:
		animated_sprite.flip_h = true
	elif direction > 0:
		animated_sprite.flip_h = false
		
	if is_on_floor():
		if direction < 0:
			animated_sprite.play("move")
		elif direction > 0:
			animated_sprite.play("move")
		else:
			animated_sprite.play("idle")
		

	move_and_slide()


func card_pickup(ele):
	element = ele
	if element == "fire":
		audio_fire.play()
		animated_sprite.material.set_shader_parameter("fire", true)
	elif element == "ice":
		audio_ice.play()
		animated_sprite.material.set_shader_parameter("ice", true)
