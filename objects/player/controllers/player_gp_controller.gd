extends PlayerController
class_name PlayerGpController


@export_range(0.001, 0.01, 0.001) var stick_dead_zone := 0.005

func _setup_controls() -> void:
	InputManager.setup_player_actions(player_id, "gp")
	InputManager.bind_player_actions_to_device(player_id, device_id)

func _get_move_vector() -> Vector2:
	var move_vector := InputManager.get_gamepad_left_stick(device_id)
	if move_vector.length() < stick_dead_zone:
		return Vector2.ZERO
	return move_vector
