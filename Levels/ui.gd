extends CanvasLayer

@export var soldier_time_increase : float = 5
@export var level_container_completer_time_increase : float = 30

@onready var player : Node2D
@onready var game_over_timer : Timer = $GameOverTimer

const GAME_OVER = preload("res://menus/game_over.tscn")

var soldiers_returned : int

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _on_player_soldier_collected():
	$Collected.text = "SOLDIERS CARRYING: " + str(player.soldiers_carrying)
	
	$SoldierCollected.play()

func _on_player__on_obstacle_hit():
	add_child(GAME_OVER.instantiate())

func _on_hangar_soldier_dropped():
	soldiers_returned += player.soldiers_carrying
	$Returned.text = "SOLDIERS RETURNED: " + str(soldiers_returned)
	
	game_over_timer.start(game_over_timer.time_left + soldier_time_increase)
	
	$SoldierReturned.play()

func _process(_delta):
	$TimeLeft.text = "TIME LEFT: " + str(int(game_over_timer.time_left)) + " SEC"

func _on_game_over_timer_timeout():
	_on_player__on_obstacle_hit()

func level_container_complete():
	game_over_timer.start(game_over_timer.time_left + level_container_completer_time_increase)
