class_name PositionTracker
extends Node2D

static var current_position : Vector2

func _process(_delta: float) -> void:
	current_position = global_position
