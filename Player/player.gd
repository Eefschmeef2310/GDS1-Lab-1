extends CharacterBody2D

signal soldier_collected()
signal soldier_dropped()
signal _on_obstacle_hit()

@export var speed : float = 200.
@export var gravity := 200.

var soldiers_carrying : int:
	set(value):
		soldiers_carrying = value
		soldier_collected.emit()

func _process(delta):
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * (speed - 30 * soldiers_carrying)
	
	velocity.y += gravity
	
	move_and_collide(velocity * delta)
	
func obstacle_hit():
	_on_obstacle_hit.emit()
