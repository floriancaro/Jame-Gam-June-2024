extends CharacterBody2D


@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_idle = $Area2D/CollisionShapeIdle
@onready var collision_side = $Area2D/CollisionShapeSide
@onready var collision_simple = $Area2D/CollisionShapeSimple
@onready var collision_spin = $Area2D/CollisionShapeSpin
@onready var kill_timer = $KillTimer
@onready var raycast = $RayCast2D
@onready var audio_circlespin = $AudioCirclespin
@onready var audio_simple = $AudioSimple
@onready var player = %Player


@export var SPEED = 100.0
@export var direction = -1

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var rng = RandomNumberGenerator.new()
var health = 5
var is_immobile = false

# Called when the node enters the scene tree for the first time.
func _ready():
	collision_side.set_deferred("disabled", true)
	collision_simple.set_deferred("disabled", true)
	collision_spin.set_deferred("disabled", true)
	$AttackTimer.start()


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if not is_immobile:
		if player.position.x - self.position.x < 0:
			direction = -1
			animated_sprite.flip_h = false
		else:
			direction = 1
			animated_sprite.flip_h = true
		if direction < 0:
			raycast.target_position.x= -75
		else:
			raycast.target_position.x = 75
		# only move if there is ground ahead
		if raycast.is_colliding():
			velocity.x = SPEED * direction
		move_and_slide()
	#move_and_collide(velocity)


func _on_area_2d_body_exited(body):
	pass


func _on_area_2d_body_entered(body):
	is_immobile = true
	$MovementTimer.start()
	if body.element == "fire" and body.is_dashing:
		hit()
	# kill_timer.start()
	if body.has_method("hit"):
		body.hit()


func hit():
	health -= 1
	if health == 0:
		animated_sprite.play("die")


#func _on_kill_timer_timeout():
	#get_tree().reload_current_scene()


func _on_attack_timer_timeout():
	# get random number to decide which attack to perform
	var random_int = rng.randi_range(0, 10)
	# simple attack
	if random_int < 5:
		audio_simple.play()
		animated_sprite.play("attack_simple")
		collision_idle.set_deferred("disabled", true)
		collision_simple.set_deferred("disabled", false)
	# side attack
	elif random_int < 9:
		audio_simple.play()
		animated_sprite.play("attack_side")
		collision_idle.set_deferred("disabled", true)
		collision_side.set_deferred("disabled", false)
	# spin attack
	else:
		animated_sprite.play("attack_spin")
		audio_circlespin.play()
		collision_idle.set_deferred("disabled", true)
		collision_spin.set_deferred("disabled", false)


func _on_animated_sprite_2d_animation_finished():
	collision_side.set_deferred("disabled", true)
	collision_simple.set_deferred("disabled", true)
	collision_spin.set_deferred("disabled", true)
	collision_idle.set_deferred("disabled", false)
	animated_sprite.play("idle")
	if health == 0:
		queue_free()


func _on_movement_timer_timeout():
	is_immobile = false


func _on_kill_timer_timeout():
	pass # Replace with function body.
