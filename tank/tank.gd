extends Sprite2D

@onready var timer = $Timer

const BULLET = preload("res://tank/bullet.tscn")

func _on_timer_timeout():
	var bullet = BULLET.instantiate()
	bullet.position = global_position
	get_tree().root.add_child(bullet)
