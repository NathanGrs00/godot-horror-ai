extends CharacterBody3D

# How fast the player moves in meters per second.
@export var walk_speed = 3.0
@export var sprint_speed = 4.0
# How fast the camera moves.
@export var mouse_sensitivity = 0.1

# Rotation to change the character rotation.
var rotation_x := 0.0
var rotation_y := 0.0

var anim_player : AnimationPlayer

func _ready():
	# Hide the OS cursor and capture it for mouse movement
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	anim_player = get_node("Pivot/Character/AnimationPlayer")

# Makes it so the camera does not rotate when interacting.
func _unhandled_input(event):
	# Check Mouse movement
	if event is InputEventMouseMotion:
		# Rotate the player to the left or right
		rotation_y -= event.relative.x * mouse_sensitivity
		# Keeps the vertical camera within a limit.
		rotation_x = clamp(rotation_x - event.relative.y * mouse_sensitivity, -30, 30)

# physics_process instead of normal process, # since this is made for character movement.
func _physics_process(delta):
	# Rotate player horizontally
	rotation.y = deg_to_rad(rotation_y)
	# Rotate SpringArm vertically
	$SpringArm3D.rotation.x = deg_to_rad(rotation_x)

	# Create a local variable to store the input direction. 
	var direction = Vector3.ZERO
	
	# If the up key or W is pressed: 
	if Input.is_action_pressed("move_forward"):
		# Move the character by 1 on the z axis. 
		# We use the Z axis because in 3D the XZ plane is the ground plane
		direction -= transform.basis.z
	# If the down key or S is pressed: 
	if Input.is_action_pressed("move_backward"):
		# Move the character by -1 on the z axis.
		direction += transform.basis.z
	# If the left key or A is pressed: 
	if Input.is_action_pressed("move_left"):
		# Move the character by -1 on the x axis. 
		direction -= transform.basis.x
	# If the right key or D is pressed: 
	if Input.is_action_pressed("move_right"):
		# Move the character by 1 on the x axis. 
		direction += transform.basis.x
	
	var current_speed = walk_speed
	if Input.is_action_pressed("run"):
		current_speed = sprint_speed
		
	if Input.is_action_pressed("quit"):
		get_tree().quit()

	# Check if player is moving: 
	if direction != Vector3.ZERO: 
		# If the player holds W and D at the same time, instead of moving at 
		# a speed of 1, it moves at a speed of 1.4, this is why we need to 
		# normalize the movement.
		direction = direction.normalized()
		
		# Check if the player is sprinting:
		if Input.is_action_pressed("run"):
			current_speed = sprint_speed
			# Change to the running animation.
			if anim_player.current_animation != "CharacterArmature|Run":
				anim_player.play("CharacterArmature|Run")
		else:
			current_speed = walk_speed
			# If not sprinting, he is walking.
			if anim_player.current_animation != "CharacterArmature|Walk":
				anim_player.play("CharacterArmature|Walk")
	else:
		# If not moving, he is idle.
		if anim_player.current_animation != "CharacterArmature|Idle":
			anim_player.play("CharacterArmature|Idle")

	# Apply movement
	velocity.x = direction.x * current_speed
	velocity.z = direction.z * current_speed

	# Move the character
	move_and_slide()
