extends Area2D

@onready var animated_sprite = $AnimatedSprite2D

@export var element = "fire"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if element == "fire":
		animated_sprite.play("fire")
	elif element == "ice":
		animated_sprite.play("ice")
	elif element == "teleport":
		animated_sprite.play("teleport")
	elif element == "nature":
		animated_sprite.play("nature")


func _on_body_entered(body):
	body.card_pickup(element)
	queue_free()
