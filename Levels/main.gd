extends Node2D

const LEVEL_CONTAINER = preload("res://Levels/level_container.tscn")

@onready var camera = $Camera2D

func _on_level_container_level_complete():
	camera.moving = true
	
	var new_level = LEVEL_CONTAINER.instantiate()
	new_level.position.x = camera.middle_point * 2
	add_child.call_deferred(new_level)
	move_child.call_deferred(new_level, 0)
