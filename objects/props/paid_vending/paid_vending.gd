extends StaticBody2D
class_name PaidVending

@export var laying_item_scene: PackedScene
@onready var interactable_area: InteractableArea = %InteractableArea
@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D
@export var dispense_item: AvailaibleItem
@export var dispense_impulse := 100.0

@export var dispense_amount := 4

enum AvailaibleItem {
	LavendSeed,
	SeaLavendSeed,
	SunnyLavendSeed,
}
var item_to_res: Dictionary[AvailaibleItem, ItemManager.Item] = {
	AvailaibleItem.LavendSeed     : ItemManager.Item.LavendSeed,
	AvailaibleItem.SeaLavendSeed  : ItemManager.Item.SeaLavendSeed,
	AvailaibleItem.SunnyLavendSeed: ItemManager.Item.SunnyLavendSeed,
}
var item_to_frame: Dictionary[AvailaibleItem, int] = {
	AvailaibleItem.LavendSeed     : 0,
	AvailaibleItem.SeaLavendSeed  : 1,
	AvailaibleItem.SunnyLavendSeed: 2,
}

func _ready() -> void:
	interactable_area.interacted.connect(_on_interact)
	sprite.frame = item_to_frame[dispense_item]

func _on_interact(player: Player) -> void:
	if !player.is_item(ItemManager.Item.Coin):
		return
	player.remove_item()
	for i in range(dispense_amount):
		_dispense_item(item_to_res[dispense_item])

func _dispense_item(item: ItemManager.Item) -> void:
	var laying_item: LayingItem = laying_item_scene.instantiate()
	YSort.y_sort_node.add_child(laying_item)
	laying_item.set_item(item)
	laying_item.global_position = global_position + Vector2(0, 16)
	laying_item.apply_impulse(Vector2.DOWN * dispense_impulse)
