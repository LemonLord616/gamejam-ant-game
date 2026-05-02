extends StaticBody2D
class_name Vending

@onready var interactable_area: InteractableArea = %InteractableArea
@onready var sprite: Sprite2D = %Sprite2D
@export var dispense_item: AvailaibleItem

enum AvailaibleItem {
	LavendCup,
	Seed,
	RandomSeed,
	LavendSeed,
	SeaLavendSeed,
	SunnyLavendSeed,
}
var item_to_res: Dictionary[AvailaibleItem, ItemManager.Item] = {
	AvailaibleItem.LavendCup      : ItemManager.Item.LavendCup,
	AvailaibleItem.Seed           : ItemManager.Item.Seed,
	AvailaibleItem.RandomSeed     : ItemManager.Item.RandomSeed,
	AvailaibleItem.LavendSeed     : ItemManager.Item.LavendSeed,
	AvailaibleItem.SeaLavendSeed  : ItemManager.Item.SeaLavendSeed,
	AvailaibleItem.SunnyLavendSeed: ItemManager.Item.SunnyLavendSeed,
}
var item_to_frame: Dictionary[AvailaibleItem, int] = {
	AvailaibleItem.LavendCup      : 0,
	AvailaibleItem.Seed           : 1,
	AvailaibleItem.RandomSeed     : 2,
	AvailaibleItem.LavendSeed     : 3,
	AvailaibleItem.SeaLavendSeed  : 4,
	AvailaibleItem.SunnyLavendSeed: 5,
}

func _ready() -> void:
	interactable_area.interacted.connect(_on_interact)
	sprite.frame = item_to_frame[dispense_item]

func _on_interact(player: Player) -> void:
	if !player.has_item():
		player.set_item(item_to_res[dispense_item])
