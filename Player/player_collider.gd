extends CollisionShape2D

signal _on_obstacle_hit()

func obstacle_hit():
	_on_obstacle_hit.emit()
