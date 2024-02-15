extends CanvasLayer

@onready var player = $"../Player"

const GAME_OVER = preload("res://menus/game_over.tscn")

var soldiers_returned : int

func _on_player_soldier_collected():
	$Collected.text = "Soldiers carrying: " + str(player.soldiers_carrying)

func _on_player_soldier_dropped():
	soldiers_returned += player.soldiers_carrying
	$Returned.text = "Soldiers returned: " + str(soldiers_returned)

func _on_player__on_obstacle_hit():
	get_tree().root.add_child(GAME_OVER.instantiate())
