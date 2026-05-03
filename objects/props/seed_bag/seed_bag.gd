extends StaticBody2D
class_name SeedBag

@onready var interactable_area: InteractableArea = %InteractableArea
@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D
@export var dispense_item: AvailaibleItem

enum AvailaibleItem {
	RandomSeed,
	LavendSeed,
	SeaLavendSeed,
	SunnyLavendSeed,
}
var item_to_res: Dictionary[AvailaibleItem, ItemManager.Item] = {
	AvailaibleItem.RandomSeed     : ItemManager.Item.RandomSeed,
	AvailaibleItem.LavendSeed     : ItemManager.Item.LavendSeed,
	AvailaibleItem.SeaLavendSeed  : ItemManager.Item.SeaLavendSeed,
	AvailaibleItem.SunnyLavendSeed: ItemManager.Item.SunnyLavendSeed,
}
var item_to_frame: Dictionary[AvailaibleItem, int] = {
	AvailaibleItem.RandomSeed     : 0,
	AvailaibleItem.LavendSeed     : 1,
	AvailaibleItem.SeaLavendSeed  : 2,
	AvailaibleItem.SunnyLavendSeed: 3,
}

func _ready() -> void:
	interactable_area.interacted.connect(_on_interact)
	sprite.frame = item_to_frame[dispense_item]

func _on_interact(player: Player) -> void:
	if !player.has_item():
		player.set_item(item_to_res[dispense_item])
