extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_idle = $CollisionShapeIdle
@onready var collision_side = $CollisionShapeSide
@onready var collision_simple = $CollisionShapeSimple
@onready var collision_spin = $CollisionShapeSpin
@onready var death_timer = $DeathTimer
@onready var attack_timer = $AttackTimer
@onready var raycast = $RayCast2D
@onready var audio_circlespin = $AudioCirclespin
@onready var audio_simple = $AudioSimple


@export var SPEED = 100
@export var direction = -1

@onready var player = %Player

var rng = RandomNumberGenerator.new()
var health = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	collision_side.set_deferred("disabled", true)
	collision_simple.set_deferred("disabled", true)
	collision_spin.set_deferred("disabled", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health > 0:
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
		
		if global_position.x <= 450 and global_position.x >= -200:
			if raycast.is_colliding():
				position.x += delta * SPEED * direction


func _on_body_entered(body):
	if body.element == "fire":
		hit()
	# kill_timer.start()
	if body.has_method("hit"):
		body.hit()


func hit():
	health -= 1
	if health == 0:
		attack_timer.stop()
		death_timer.start()
		animated_sprite.play("die")
		$AntiBobText.visible = true


func _on_attack_timer_timeout():
	# get random number to decide which attack to perform
	var random_int = rng.randi_range(0, 10)
	# spin attack
	if random_int < 5:
		audio_simple.play()
		animated_sprite.play("attack_simple")
		collision_idle.set_deferred("disabled", true)
		collision_simple.set_deferred("disabled", false)
	# spin attack
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
	if health > 0:
		collision_side.set_deferred("disabled", true)
		collision_simple.set_deferred("disabled", true)
		collision_spin.set_deferred("disabled", true)
		collision_idle.set_deferred("disabled", false)
		animated_sprite.play("idle")


func _on_death_timer_timeout():
	queue_free()
