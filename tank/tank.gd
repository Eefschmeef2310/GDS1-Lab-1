extends Node2D

@export var speed : float = 2

@onready var timer = $Timer
@onready var player : Node2D

const BULLET = preload("res://tank/bullet.tscn")

func _ready():
	player = get_tree().get_first_node_in_group("player")
	
func _process(delta):
	global_position.x = lerp(global_position.x, player.global_position.x, speed * delta)

func _on_timer_timeout():
	var bullet = BULLET.instantiate()
	bullet.position = $BulletMarker.global_position
	get_tree().root.add_child(bullet)
	
	$BulletShoot.play()
	$AnimationPlayer.play("shoot")
	
	timer.start(DifficultyManager.get_tank_shoot_speed())
