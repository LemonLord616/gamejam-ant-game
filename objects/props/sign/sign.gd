extends Node2D
class_name Sign

@export_multiline var text: String

@onready var interactable_area: InteractableArea = %InteractableArea

func _ready() -> void:
	interactable_area.interacted.connect(_on_interact)

func _on_interact(player: Player) -> void:
	ui.show_text(text)
