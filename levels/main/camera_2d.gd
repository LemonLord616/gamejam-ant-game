extends Node2D


@export var player: Player
@export var follow_curve: Curve
@export_range(100.0, 1000.0, 1.0) var max_distance: float = 400.0


func _physics_process(delta: float) -> void:
	var distance := global_position.distance_to(player.global_position)
	var t = clamp(distance / max_distance, 0.0, 1.0)
	var curve_value := follow_curve.sample(t)
	global_position = global_position.lerp(
		player.global_position, curve_value
	)
