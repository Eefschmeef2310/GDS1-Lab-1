extends Area2D

@export var tree_count : int
@export var soldier_count : int

const TREE = preload("res://objects/tree.tscn")
const SOLDIER = preload("res://Soldiers/Soldier.tscn")

@onready var bounds = $Bounds

var circles : Array[Circle]
var objects : Array[CollisionObject2D]

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

func _ready():
	#Generate trees
	for i in tree_count:
		instantiate_object(TREE)
		
	#Generate soldiers
	for i in soldier_count:
		instantiate_object(SOLDIER)

#for debugging purposes
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		reset()
		_ready()
		
#Create object and ensure they don't overlap
func instantiate_object(object_to_create):
	var object = object_to_create.instantiate() as CollisionObject2D
	var random_position = get_random_position()
	while check_overlap(random_position, object):
		random_position = get_random_position()
	object.position = global_position + random_position
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
