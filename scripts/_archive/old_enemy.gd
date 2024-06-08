extends Node2D

@export var SPEED = 100
@onready var animated_sprite = $AnimatedSprite2D

var direction = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animated_sprite.play("move")
	position.x += delta * SPEED * direction


func _on_timer_timeout():
	direction *= -1
	animated_sprite.flip_h = not animated_sprite.flip_h
	
