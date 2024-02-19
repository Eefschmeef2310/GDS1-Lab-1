extends StaticBody2D

#TODO - Move this into bullets instead
func _on_body_entered(body):
	if body.is_in_group("player"):
		body.obstacle_hit()
