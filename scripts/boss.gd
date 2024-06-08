extends Area2D

@export var projectile_scene: PackedScene
@export var health = 5

@onready var projectile_marker = $ProjectileMarker
@onready var kill_timer = $KillTimer


func _on_body_entered(body):
	kill_timer.start()
	if body.has_method("hit"):
		body.hit()


func fire_projectile():
	var projectile = projectile_scene.instantiate()
	projectile.position = projectile_marker.global_position
	get_tree().get_root().add_child(projectile)


func hit():
	health -= 1
	if health == 0:
		queue_free()


func _on_projectile_timer_timeout():
	fire_projectile()


func _on_kill_timer_timeout():
	get_tree().reload_current_scene()
