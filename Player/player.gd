extends CharacterBody2D

signal soldier_collected()
signal _on_obstacle_hit()

@export var speed : float = 200.
@export var gravity := 200.
@export var heaviness_scale : float = 75
@export var rotation_clamp : float = 20

@onready var soldier_carry_bar = $SoldierCarryBar

var soldiers_carrying : int:
	set(value):
		soldiers_carrying = value
		soldier_collected.emit()
		
		#update bar
		soldier_carry_bar.update(value)

func _process(delta):
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	
	#move player
	velocity = lerp(velocity, direction * (speed - heaviness_scale * soldiers_carrying), 0.05)
	#Apply gravity
	velocity.y += gravity
	move_and_collide(velocity * delta)
	
	#rotate player
	rotation_degrees = lerp(rotation_degrees, direction.x * rotation_clamp, 0.05)
	
	if direction != Vector2.ZERO:
		if !$Rotor.playing:
			$Rotor.play()
	elif $Rotor.playing:
		$Rotor.stop()
	
func obstacle_hit():
	_on_obstacle_hit.emit()
