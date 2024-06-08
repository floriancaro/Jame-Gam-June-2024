extends Area2D

@export var SPEED = 300

@onready var animated_sprite = $AnimatedSprite2D

var direction = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if direction == 1:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
	
	position.x += direction * SPEED * delta


func _on_area_entered(area):
	if area.has_method("hit"):
		area.hit()
		queue_free()
