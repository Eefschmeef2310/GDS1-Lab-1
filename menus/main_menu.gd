extends Control

const CREDITS = preload("res://menus/credits.tscn")

func _ready():
	for i in get_tree().get_nodes_in_group("bullet"):
		i.queue_free()
	$"MarginContainer/VBoxContainer/High Score".text = "HIGH SCORE: " + str(SaveManager.save_game.high_score)

func _on_quit_pressed():
	get_tree().quit()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Levels/Main.tscn")

func _on_credits_pressed():
	add_child(CREDITS.instantiate())
