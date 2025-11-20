extends State
class_name EnemyIdle

# Get the Zombie
@export var enemy: CharacterBody3D
# set the move speed
@export var move_speed := 1.0

var player: CharacterBody3D

# variables
var move_direction : Vector3
var wander_time : float

# Function to randomize direction to walk to
func randomize_wander():
	# Vector3 takes XYZ cords.
	move_direction = Vector3(randf_range(-1, 1), 0, randf_range(-1, 1)).normalized()
	# Randomize the time as well
	wander_time = randf_range(1, 3)
	
# When first wandering, randomize wander
func Enter():
	player = get_tree().get_first_node_in_group("player")
	randomize_wander()
	
# When updating
func Update(delta: float):
	# If the wander time is more than 0,
	if wander_time > 0:
		# update time
		wander_time -= delta
		
	else:
		# If it is 0, than randomize again.
		randomize_wander()
		
func Physics_Update(delta: float):
	if enemy: 
		# Setting path.
		enemy.velocity = move_direction * move_speed
	
	var direction = player.global_position - enemy.global_position
	
	if direction.length() < 30:
		Transitioned.emit(self, "follow")
		
	enemy.get_node("AnimationPlayer").play("Armature|Walk")
	
	if move_direction.length() > 0.1:
		var look_pos = enemy.global_position - move_direction
		enemy.look_at(look_pos, Vector3.UP)

	enemy.move_and_slide()
	
