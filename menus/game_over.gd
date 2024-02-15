extends Control

func _ready():
	get_tree().paused = true

func _on_restart_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Levels/Main.tscn")
	queue_free()
