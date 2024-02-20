extends PathFollow2D

var player : Node2D

@export var speed : float = 4

func _ready():
	player = get_tree().get_first_node_in_group("player")
	
	#stops function if player not present
	process_mode = Node.PROCESS_MODE_INHERIT if player else PROCESS_MODE_DISABLED

func _process(delta):
	progress = lerp(progress, player.position.x, speed * delta)
