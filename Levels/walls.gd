extends Node2D

@onready var camera = $"../Camera2D"

func _process(_delta):
	global_position = camera.position - Vector2(576, 324)
