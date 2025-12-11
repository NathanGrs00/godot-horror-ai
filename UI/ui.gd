extends Control

var collected := 0
# Total spheres in the map
const TOTAL := 10 

# Update the counter when loaded in.
func _ready():
	update_counter()

# Call this whenever a sphere is collected
func add_collectible():
	collected += 1
	update_counter()
	# Check if 10 has been reached
	check_win()

func update_counter():
	$CollectCounter.text = str(collected, " / ", TOTAL)

# Win condition
func check_win():
	if collected >= TOTAL:
		#TODO: Remove this with win screen.
		print("You Win!")
