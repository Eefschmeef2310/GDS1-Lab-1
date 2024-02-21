extends Node2D

signal level_complete()

const LEVEL_COMPLETE_UI = preload("res://ui/level_complete_ui.tscn")

@onready var hangar = $Hangar

func _ready():
	hangar.soldier_dropped.connect(_soldier_released)
	get_parent().generate_level.connect(generate_objects)
	get_parent().init_new_level(self)

func _soldier_released():
	if !get_tree().get_nodes_in_group("soldier").size():
		add_child(LEVEL_COMPLETE_UI.instantiate())
		level_complete.emit()

func _on_visible_on_screen_notifier_2d_screen_exited():
	if $VisibleOnScreenNotifier2D.process_mode == PROCESS_MODE_INHERIT:
		queue_free()

func generate_objects():
	$VisibleOnScreenNotifier2D.process_mode = Node.PROCESS_MODE_INHERIT
	get_parent().generate_level.disconnect(generate_objects)
	$ObjectGenerator.generate_level()
