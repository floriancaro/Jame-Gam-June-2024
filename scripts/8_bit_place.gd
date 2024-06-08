extends Area2D

@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	label.visible = false


func _on_body_entered(body):
	label.visible = true


func _on_body_exited(body):
	label.visible = false
