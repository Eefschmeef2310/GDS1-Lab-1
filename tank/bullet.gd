extends Area2D

@export var speed : float = 100

func _process(delta):
	position.y -= speed * delta
	
func _on_body_entered(body):
	if "obstacle_hit" in body:
		body.obstacle_hit()
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
