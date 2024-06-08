extends Area2D

@export var SPEED = 250


@onready var animated_sprite = $AnimatedSprite2D

var direction = -1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += direction * SPEED * delta


func _on_body_entered(body):
	if body.has_method("hit"):
		body.hit()
		
		queue_free()


# remove projectile after some time
func _on_timer_timeout():
	queue_free()
