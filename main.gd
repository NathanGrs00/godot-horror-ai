extends Node

@onready var player = $Player

func _physics_process(delta):
	# Get the player position and give it to all nodes in the group enemies.
	get_tree().call_group("enemies", "update_target_location", player.global_transform.origin)
	
func _ready():
	MusicManager.play_normal()
	
	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.connect("game_over", Callable(self, "_on_game_over"))

func _on_game_over():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	MusicManager.stop_all()
	get_tree().change_scene_to_file("res://UI/game_over.tscn")
