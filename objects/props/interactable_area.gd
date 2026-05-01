extends Area2D
class_name InteractableArea


@export var prop_sprite: Sprite2D

## Don't forget to set up collision layer and mask

signal interacted(player: Player)

func interact(player: Player) -> void:
	interacted.emit(player)

func get_selection_size() -> Vector2:
	if not prop_sprite:
		return Vector2(32, 32)
	return prop_sprite.get_rect().size
