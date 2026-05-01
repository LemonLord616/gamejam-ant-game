extends Area2D
class_name InteractableArea


@export var selection_size := Vector2(32, 32)

## Don't forget to set up collision layer and mask

signal interacted(player: Player)

func interact(player: Player) -> void:
	interacted.emit(player)

func get_selection_size() -> Vector2:
	return selection_size
