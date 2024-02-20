extends Camera2D

signal next_level_reached()

var middle_point : float
var moving : bool = false:
	set(value):
		moving = value
		middle_point = get_viewport_rect().size.x / 2

@onready var player = $"../Player"

#moves camera to player's x position, without going outside the world boundaries
func _process(_delta):
	if moving:
		position.x = player.position.x
		position.x = clamp(position.x, middle_point, middle_point * 3)
		if position.x == middle_point * 3:
			moving = false
