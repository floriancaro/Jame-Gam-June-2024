extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_idle = $CollisionShapeIdle
@onready var collision_side = $CollisionShapeSide
@onready var collision_simple = $CollisionShapeSimple
@onready var collision_spin = $CollisionShapeSpin
@onready var kill_timer = $KillTimer

var rng = RandomNumberGenerator.new()
var health = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	collision_side.set_deferred("disabled", true)
	collision_simple.set_deferred("disabled", true)
	collision_spin.set_deferred("disabled", true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	kill_timer.start()
	Engine.time_scale = 0.5
	body.get_node("AudioDeath").play()
	body.get_node("CollisionShape2D").queue_free()


func hit():
	health -= 1
	if health == 0:
		animated_sprite.play("die")


func _on_kill_timer_timeout():
	get_tree().reload_current_scene()


func _on_attack_timer_timeout():
	# get random number to decide which attack to perform
	var random_int = rng.randi_range(0, 10)
	# spin attack
	if random_int < 5:
		animated_sprite.play("attack_simple")
		collision_idle.set_deferred("disabled", true)
		collision_simple.set_deferred("disabled", false)
	# spin attack
	elif random_int < 9:
		animated_sprite.play("attack_side")
		collision_idle.set_deferred("disabled", true)
		collision_side.set_deferred("disabled", false)
	# spin attack
	else:
		animated_sprite.play("attack_spin")
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
