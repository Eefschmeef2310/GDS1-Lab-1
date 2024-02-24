extends CanvasLayer

@export var soldier_time_increase : float = 5
@export var level_container_completer_time_increase : float = 30
@export var max_timer : float = 120

@onready var player : Node2D
@onready var game_over_timer : Timer = $TimeLeft/GameOverTimer

const GAME_OVER = preload("res://menus/game_over.tscn")

var soldiers_returned : int

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _on_player_soldier_collected():
	$SoldierCollected.play()

func _on_player__on_obstacle_hit():
	add_child(GAME_OVER.instantiate())

func _on_hangar_soldier_dropped():
	soldiers_returned += player.soldiers_carrying
	$Returned.text = str(soldiers_returned)
	
	game_over_timer.start(clamp(game_over_timer.time_left + soldier_time_increase, 0, max_timer))
	
	$SoldierReturned.play()

func _process(_delta):
	$TimeLeft.update()

func _on_game_over_timer_timeout():
	_on_player__on_obstacle_hit()

func level_container_complete():
	game_over_timer.start(clamp(game_over_timer.time_left + level_container_completer_time_increase, 0, max_timer))
