extends Control

@onready var score_text : Label = $MarginContainer/VBoxContainer/Score

func _ready():
	if SaveManager.save_game.high_score - get_parent().soldiers_returned > 0:
		score_text.text = "ONLY " + str(SaveManager.save_game.high_score - get_parent().soldiers_returned) + " AWAY FROM HIGH SCORE!"
	elif SaveManager.save_game.high_score - get_parent().soldiers_returned == 0:
		score_text.text = "REACHED HIGH SCORE!"
	else:
		score_text.text = "NEW HIGH SCORE"
		
	SaveManager.update_score(get_parent().soldiers_returned)
	
	get_tree().paused = true
	
func move(level : String):
	get_tree().paused = false
	get_tree().change_scene_to_file(level)
	queue_free()

func _on_restart_pressed():
	move("res://Levels/Main.tscn")

func _on_menu_pressed():
	move("res://menus/main_menu.tscn")
