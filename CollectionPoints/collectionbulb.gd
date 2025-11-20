extends Node3D

@export var points := 1 

func _ready():
	# Make sure collision detects area
	if has_node("CollisionShape3D"):
		$CollisionShape3D.disabled = false

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		get_node("/root/Main/UICanvas/UI").add_collectible()
		# Remove the parent Node3D (the whole collectible)
		get_parent().get_parent().queue_free()
