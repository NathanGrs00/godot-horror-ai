extends Node

@onready var player = $Player

func _physics_process(delta):
	# Get the player position and give it to all nodes in the group enemies.
	get_tree().call_group("enemies", "update_target_location", player.global_transform.origin)
	
func _ready():
	MusicManager.play_normal()
