extends Node2D

@onready var player = %Player
@onready var sprite_hp0 = player.get_node("HealthBar/HP0")
@onready var sprite_hp1 = player.get_node("HealthBar/HP1")
@onready var sprite_hp2 = player.get_node("HealthBar/HP2")
@onready var sprite_hp3 = player.get_node("HealthBar/HP3")
@onready var sprite_hp4 = player.get_node("HealthBar/HP4")
@onready var sprite_hp5 = player.get_node("HealthBar/HP5")

#const MIN_POSITION_Y = -240

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_hp0.visible = true
	sprite_hp1.visible = false
	sprite_hp2.visible = false
	sprite_hp3.visible = false
	sprite_hp4.visible = false
	sprite_hp5.visible = false

func _process(delta):
	#global_position.y = clamp(position.y, -10000, -240)
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
		
