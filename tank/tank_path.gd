extends PathFollow2D

var player

@export var speed : float = 10

func _ready():
	player = get_tree().get_first_node_in_group("player")
	
	#stops function if player not present
	print("player not found")
	process_mode = Node.PROCESS_MODE_ALWAYS if player else PROCESS_MODE_DISABLED

func _process(delta):
	progress = lerp(player.global_position.x, progress, speed * delta)
