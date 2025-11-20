extends CharacterBody3D

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

# Optionally put speed here if you want
@export var move_speed: float = 3.0
