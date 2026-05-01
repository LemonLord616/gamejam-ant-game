extends StaticBody2D
class_name Vending

@onready var interactable_area: InteractableArea = %InteractableArea
@onready var sprite: Sprite2D = %Sprite2D
@export var dispense_item: AvailaibleItem

enum AvailaibleItem {
	LavendCup,
	Seed
}
var item_to_res: Dictionary[AvailaibleItem, ItemManager.Item] = {
	AvailaibleItem.LavendCup: ItemManager.Item.LavendCup,
	AvailaibleItem.Seed: ItemManager.Item.Seed
}
var item_to_frame: Dictionary[AvailaibleItem, int] = {
	AvailaibleItem.LavendCup: 0,
	AvailaibleItem.Seed: 1
}

func _ready() -> void:
	interactable_area.interacted.connect(_on_interact)
	sprite.frame = item_to_frame[dispense_item]

func _on_interact(player: Player) -> void:
	if !player.has_item():
		player.set_item(item_to_res[dispense_item])
