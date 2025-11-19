extends CharacterBody3D

# Store the reference to the NavigationAgent in nav_agent.
@onready var nav_agent = $NavigationAgent3D

# Speed of the zombie
var SPEED = 3.0

# Function which updates at all times
func _physics_process(delta):
	# Get the current location of the zombie.
	var current_location = global_transform.origin
	# Get the next location.
	var next_location = nav_agent.get_next_path_position()
	# Calculate the velocity in which you need to travel to the next location, based on speed.
	var new_velocity = (next_location - current_location).normalized() * SPEED
	
	# Set the velocity.
	velocity = new_velocity
	# Move.
	move_and_slide()
	
# This method is called from the world node, it sets the next position of the NavigationAgent.
func update_target_location(target_location):
	nav_agent.set_target_position(target_location)
	
