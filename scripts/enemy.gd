extends Area2D

@onready var move_timer = $MovementTimer
@onready var kill_timer = $KillTimer

@export var SPEED = 100
@onready var animated_sprite = $AnimatedSprite2D
@export var direction = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animated_sprite.play("move")
	position.x += delta * SPEED * direction


func hit():
	queue_free()


func _on_body_entered(body):
	kill_timer.start()
	if body.has_method("hit"):
		body.hit()


func _on_movement_timer_timeout():
	direction *= -1
	animated_sprite.flip_h = not animated_sprite.flip_h


#func _on_kill_timer_timeout():
	#get_tree().reload_current_scene()
