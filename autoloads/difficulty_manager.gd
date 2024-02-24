extends Node

@export var soldier_curve : Curve
@export var tree_curve : Curve
@export var tank_shoot_speed_curve : Curve

@export var frequency : int = 5

var levels_cleared : int = 0

func get_soldier_spawn_amount():
	return int(soldier_curve.sample(float(levels_cleared) / frequency) * frequency)

func get_tree_spawn_amount():
	return int(tree_curve.sample(float(levels_cleared) / frequency) * frequency)

func get_tank_shoot_speed():
	return tank_shoot_speed_curve.sample(float(levels_cleared) / frequency) * frequency
