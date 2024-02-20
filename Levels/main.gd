extends Node2D

signal generate_level()

const LEVEL_CONTAINER = preload("res://Levels/level_container.tscn")

@onready var camera = $Camera2D

func _ready():
	generate_level.emit()

func _on_level_container_level_complete():
	camera.moving = true
	
	var new_level = LEVEL_CONTAINER.instantiate()
	new_level.position.x = camera.middle_point + get_viewport_rect().size.x / 2
	add_child.call_deferred(new_level)
	move_child.call_deferred(new_level, 0)

func init_new_level(new_level):
	new_level.level_complete.connect(_on_level_container_level_complete)
