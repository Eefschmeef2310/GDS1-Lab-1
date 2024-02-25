extends Area2D

var ui : CanvasLayer

signal soldier_dropped()

func _ready():
	ui = get_tree().get_first_node_in_group("ui")
	soldier_dropped.connect(ui._on_hangar_soldier_dropped)

func _on_body_entered(body):
	if body.is_in_group("player") && body.soldiers_carrying > 0:
		soldier_dropped.emit()
		body.soldiers_carrying = 0
		$GPUParticles2D.emitting = true
