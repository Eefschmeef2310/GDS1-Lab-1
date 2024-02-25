extends Camera2D

signal next_level_reached()

var middle_point : float
var moving : bool = false

@onready var player = $"../Player"

func _ready():
	middle_point = get_viewport_rect().size.x / 2

#moves camera to player's x position, without going outside the world boundaries
func _process(_delta):
	if moving:
		position.x = player.position.x
		position.x = clamp(position.x, middle_point, middle_point + get_viewport_rect().size.x)
		
		#Spawn next level when halfway between
		if position.x >= middle_point + get_viewport_rect().size.x / 2:
			get_parent().generate_level.emit()
		
		if position.x == middle_point + get_viewport_rect().size.x:
			moving = false
			middle_point += get_viewport_rect().size.x
