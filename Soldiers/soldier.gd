extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player") and body.soldiers_carrying < 3:
		body.soldiers_carrying += 1
		queue_free()
