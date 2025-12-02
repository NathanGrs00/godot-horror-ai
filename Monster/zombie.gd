extends CharacterBody3D
signal game_over

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

# Optionally put speed here if you want
@export var move_speed: float = 3.0

func _on_state_gameover():
	emit_signal("game_over")
