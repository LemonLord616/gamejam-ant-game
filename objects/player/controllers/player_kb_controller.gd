extends PlayerController
class_name PlayerKbController

func _setup_controls() -> void:
	InputManager.setup_player_actions(player_id, "kb")

func _get_move_vector() -> Vector2:
	return Input.get_vector(
		prefix + "move_left", prefix + "move_right", prefix + "move_up", prefix + "move_down"
	)
