extends Area2D

@export var speed : float = 100

func _process(delta):
	position.y -= speed * delta
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		body.obstacle_hit()

