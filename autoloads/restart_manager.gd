extends Node

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event):
	if event.is_action_pressed("Restart"):
		get_tree().paused = false
		get_tree().reload_current_scene()
