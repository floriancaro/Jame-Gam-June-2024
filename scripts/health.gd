extends Node2D

@onready var sprite_hp0 = $Camera2D/HP0
@onready var sprite_hp1 = $Camera2D/HP1
@onready var sprite_hp2 = $Camera2D/HP2
@onready var sprite_hp3 = $Camera2D/HP3
@onready var sprite_hp4 = $Camera2D/HP4
@onready var sprite_hp5 = $Camera2D/HP5
@onready var player = %Player

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_hp0.visible = true
	sprite_hp1.visible = false
	sprite_hp2.visible = false
	sprite_hp3.visible = false
	sprite_hp4.visible = false
	sprite_hp5.visible = false

func _process(delta):
	if player.health >= 1:
		sprite_hp1.visible = true
	else:
		sprite_hp1.visible = false
	if player.health >= 2:
		sprite_hp2.visible = true
	else:
		sprite_hp2.visible = false
	if player.health >= 3:
		sprite_hp3.visible = true
	else:
		sprite_hp3.visible = false
	if player.health >= 4:
		sprite_hp4.visible = true
	else:
		sprite_hp4.visible = false
	if player.health >= 5:
		sprite_hp5.visible = true
	else:
		sprite_hp5.visible = false
		
