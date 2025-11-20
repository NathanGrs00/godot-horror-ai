extends State
class_name EnemyFollow

# Get the zombie and speed
@export var enemy: CharacterBody3D
@export var move_speed := 3.0

# variables
var player: CharacterBody3D
var nav_agent: NavigationAgent3D

# When first changed into state
func Enter():
	# Get the player and NavigationAgent3D
	player = get_tree().get_first_node_in_group("player")
	nav_agent = enemy.get_node("NavigationAgent3D")
	# Change the target_position to the player's global position
	nav_agent.target_position = player.global_position
	
func Physics_Update(delta: float):
	# If player is somehow null, return
	if player == null:
		return
	
	# Set the target position again
	nav_agent.target_position = player.global_position
	
	# Get the next path position
	var next_pos = nav_agent.get_next_path_position()
	
	# Get the distance from the next pos to the zombie position.
	var direction = (next_pos - enemy.global_position)
	
	# Check if zombie is outside of range
	if enemy.global_position.distance_to(player.global_position) > 20: 
		Transitioned.emit(self, "idle")
	
	# If that length is less than 1, meaning the zombie is next to the player
	if direction.length() < 1.0:
		# Set the velocity to 0.
		enemy.velocity = Vector3.ZERO
		return
	
	# other wise, set the velocity to the distance * speed.
	enemy.velocity = direction.normalized() * move_speed
	
	# If the zombie is moving
	if enemy.velocity.length() > 0.1:
		var facing_direction = -enemy.velocity.normalized()
		enemy.look_at(enemy.global_position + facing_direction, Vector3.UP)
		# play the walk animation
		enemy.get_node("AnimationPlayer").play("Armature|Running_Crawl")
	
	# move it!
	enemy.move_and_slide()
