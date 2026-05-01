extends StaticBody2D
class_name TrashCan

@onready var interactable_area: InteractableArea = %InteractableArea

func _ready() -> void:
	interactable_area.interacted.connect(_on_interact)

func _on_interact(player: Player) -> void:
	if player.has_item():
		player.remove_item()
