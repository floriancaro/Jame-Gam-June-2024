extends Node2D

@export var SPEED = 100
@onready var animtated_sprite = $AnimatedSprite2D

var direction = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += delta * SPEED * direction


func _on_timer_timeout():
	direction *= -1
	animtated_sprite.flip_h = not animtated_sprite.flip_h
	
