extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player") && body.soldiers_carrying > 0:
		body.soldier_dropped.emit()
		body.soldiers_carrying = 0
