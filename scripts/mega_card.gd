extends Area2D

var element = "mega"

func _on_body_entered(body):
	body.card_pickup(element)
	queue_free()
