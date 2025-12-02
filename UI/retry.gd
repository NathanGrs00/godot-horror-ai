extends Control

@export var main_scene_path: String = "res://main.tscn"

func _ready():
	$Retry.connect("pressed", Callable(self, "_on_Retry_pressed"))
	
func _on_Retry_pressed():
	get_tree().change_scene_to_file(main_scene_path)
