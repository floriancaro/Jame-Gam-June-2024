extends CharacterBody2D


@export var SPEED = 250.0
@export var SPEED_DASH = 500.0
@export var JUMP_VELOCITY = -300.0
@export var projectile_scene: PackedScene

@onready var animated_sprite = $AnimatedSprite2D
@onready var projectile_marker = $ProjectileMarker
@onready var audio_fire = $AudioFire
@onready var audio_ice = $AudioIce
@onready var collision_shape = $CollisionShape2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var element = "nature"
var in_animation = false
var	ability_charged = true
var is_dashing = false


func _ready():
	animated_sprite.material.set_shader_parameter("fire", false)
	animated_sprite.material.set_shader_parameter("ice", false)


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if not in_animation:
			animated_sprite.play("jump")
	
	# handle abilities
	if Input.is_action_pressed("ability") and ability_charged:
		activate_ability()

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction < 0:
		animated_sprite.flip_h = true
		projectile_marker.position.x = -10
	elif direction > 0:
		animated_sprite.flip_h = false
		projectile_marker.position.x = 10
		
	if is_on_floor() and not in_animation:
		if direction < 0:
			animated_sprite.play("move")
		elif direction > 0:
			animated_sprite.play("move")
		else:
			animated_sprite.play("idle")
	
	if is_dashing:
		if animated_sprite.flip_h:
			velocity.x = -1 * SPEED_DASH
		else:
			velocity.x = 1 * SPEED_DASH
	
	move_and_slide()


func activate_ability():
	if element == "ice":
		fire_projectile()
	elif element == "fire":
		dash()
	elif element == "teleport":
		teleport()
	$AbilityTimer.start()
	ability_charged = false


func dash():
	set_collision_layer_value(2, false)
	animated_sprite.play("dash")
	is_dashing = true
	in_animation = true


func teleport():
	# animated_sprite.play("teleport")
	in_animation = true
	if animated_sprite.flip_h:
		position.x -= 100
	else:
		position.x += 100


func fire_projectile():
	var projectile = projectile_scene.instantiate()
	projectile.position = projectile_marker.global_position
	if velocity.x != 0:
		projectile.SPEED += SPEED
	if animated_sprite.flip_h:
		projectile.direction = -1
	else:
		projectile.direction = 1
	get_parent().add_child(projectile)


func card_pickup(ele):
	element = ele
	if element == "fire":
		audio_fire.play()
		animated_sprite.play("henshi_fire")
		animated_sprite.material.set_shader_parameter("fire", true)
	elif element == "ice":
		audio_ice.play()
		animated_sprite.play("henshi_ice")
		animated_sprite.material.set_shader_parameter("ice", true)
	elif element == "teleport":
		audio_ice.play()
		animated_sprite.play("henshi_teleport")
		animated_sprite.material.set_shader_parameter("teleport", true)
	in_animation = true


func _on_animated_sprite_2d_animation_finished():
	in_animation = false
	is_dashing = false
	set_collision_layer_value(2, true)


func _on_ability_timer_timeout():
	ability_charged = true
