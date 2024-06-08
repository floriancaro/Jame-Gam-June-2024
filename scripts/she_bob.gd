extends Area2D

@onready var player = %Player
@onready var animated_sprite = $AnimatedSprite2D
@onready var game_manager = %GameManager

var rescued = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.position.x - self.position.x < 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
		
	if rescued:
		animated_sprite.play("idle")


func _on_body_entered(body):
	rescued = true
	game_manager.get_node("Text/RescueLabel").show()
