extends Area2D

func _on_body_entered(body):
	if "obstacle_hit" in body:
		body.obstacle_hit()
		queue_free()
