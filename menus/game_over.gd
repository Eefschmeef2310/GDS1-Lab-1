extends Control

func _ready():
	get_tree().paused = true
	
func move(level : String):
	get_tree().paused = false
	get_tree().change_scene_to_file(level)
	queue_free()

func _on_restart_pressed():
	move("res://Levels/Main.tscn")

func _on_menu_pressed():
	move("res://menus/main_menu.tscn")
