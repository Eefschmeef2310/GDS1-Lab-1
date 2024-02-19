extends Area2D

const TREE = preload("res://objects/tree.tscn")

@onready var bounds = $Bounds

func _ready():
	for i in range(0, 10):
		var tree = TREE.instantiate() as Area2D
		var random_position = get_random_position()
		while check_overlap(random_position, tree):
			random_position = get_random_position()
		tree.position = global_position + random_position
		get_tree().root.add_child.call_deferred(tree)

func check_overlap(position, tree : Area2D):
	var space_state = get_world_2d().direct_space_state
	var shape = PhysicsServer2D.circle_shape_create()
	var params = PhysicsShapeQueryParameters2D.new()
	
	# Physics check
	PhysicsServer2D.shape_set_data(shape, tree.shape_owner_get_shape(0, 0).get_rect().size.y)
	
	params.shape_rid = shape
	params.transform = Transform2D(0, position)
		
	var result = space_state.intersect_shape(params, 1)
	return result.size() != 0
	
func get_random_position():
	#Gets a random position within the collision shape
	return Vector2(randf_range(-bounds.get_shape().get_rect().size.x/2, bounds.get_shape().get_rect().size.x/2), 
				   randf_range(-bounds.get_shape().get_rect().size.y/2, bounds.get_shape().get_rect().size.y/2))
