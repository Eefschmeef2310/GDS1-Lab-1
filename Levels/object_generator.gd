extends Area2D

@export var tree_count : int
@export var soldier_count : int

const TREE = preload("res://objects/tree.tscn")
const SOLDIER = preload("res://Soldiers/Soldier.tscn")
const TANK = preload("res://tank/tank.tscn")

@onready var bounds = $Bounds
@onready var tank_marker = $"../TankMarker"

var circles : Array[Circle]
var objects : Array[CollisionObject2D]
var tank : Node2D

#Circle class to prevent intersecting objects
class Circle:
	var center := Vector2.ZERO
	var radius := 1.0
	func _init(_center: Vector2, _radius: float):
		center = _center
		radius = _radius
	func intersects(other_circle: Circle) -> bool:
		var radii_sum_sq = (radius + other_circle.radius) * (radius + other_circle.radius)
		if center.distance_squared_to(other_circle.center) < radii_sum_sq:
			return true
		return false

func generate_level():
	#Generate trees
	for i in tree_count:
		instantiate_object(TREE)
		
	#Generate soldiers
	for i in soldier_count:
		instantiate_object(SOLDIER)
		
	#Generate tank
	tank = TANK.instantiate()
	tank.global_position = tank_marker.global_position
	get_parent().add_child.call_deferred(tank)
	get_parent().level_complete.connect(tank.destroy)

#for debugging purposes
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		reset()
		generate_level()
		
#Create object and ensure they don't overlap
func instantiate_object(object_to_create):
	var object = object_to_create.instantiate() as CollisionObject2D
	var random_position = get_random_position()
	while check_overlap(random_position, object):
		random_position = get_random_position()
	object.position = position + random_position
	get_parent().add_child.call_deferred(object)
	objects.append(object)

func check_overlap(pos, tree : CollisionObject2D):
	var new_circle = Circle.new(pos, max(tree.shape_owner_get_shape(0, 0).get_rect().size.y/2, tree.shape_owner_get_shape(0, 0).get_rect().size.x/2))
	for index in circles:
		if index.intersects(new_circle):
			return true
	circles.append(new_circle)
	return false
	
func get_random_position():
	#Gets a random position within the collision shape
	return Vector2(randf_range(-bounds.get_shape().get_rect().size.x/2, bounds.get_shape().get_rect().size.x/2), 
				   randf_range(-bounds.get_shape().get_rect().size.y/2, bounds.get_shape().get_rect().size.y/2))
				
func reset():
	for i in objects:
		i.queue_free()
	objects.clear()
	circles.clear()
	tank.queue_free()

func _on_level_container_generate_level():
	generate_level()
