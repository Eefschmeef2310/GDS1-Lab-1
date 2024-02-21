extends CanvasLayer

@export var soldier_time_increase : float = 5
@export var level_container_completer_time_increase : float = 30

@onready var player = $"../Player"
@onready var game_over_timer : Timer = $GameOverTimer

const GAME_OVER = preload("res://menus/game_over.tscn")

var soldiers_returned : int

func _on_player_soldier_collected():
	$Collected.text = "Soldiers carrying: " + str(player.soldiers_carrying)

func _on_player__on_obstacle_hit():
	get_tree().root.add_child(GAME_OVER.instantiate())

func _on_hangar_soldier_dropped():
	soldiers_returned += player.soldiers_carrying
	$Returned.text = "Soldiers returned: " + str(soldiers_returned)
	
	game_over_timer.start(game_over_timer.time_left + soldier_time_increase)

func _process(_delta):
	$TimeLeft.text = "TIME LEFT: " + str(int(game_over_timer.time_left)) + "s"

func _on_game_over_timer_timeout():
	_on_player__on_obstacle_hit()

func level_container_complete():
	game_over_timer.start(game_over_timer.time_left + level_container_completer_time_increase)
