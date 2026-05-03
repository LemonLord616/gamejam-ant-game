extends StaticBody2D
class_name SeedBag

@onready var interactable_area: InteractableArea = %InteractableArea
@onready var sprite: AnimatedSprite2D = %AnimatedSprite2D

@export var dispense_item: AvailaibleItem
@export var cooldown_time: float = 15 

var is_on_cooldown: bool = false 

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
	if is_on_cooldown:
		return

	if !player.has_item():
		player.set_item(item_to_res[dispense_item])
		
		if dispense_item != AvailaibleItem.RandomSeed:
			queue_free()
		else:
			start_cooldown()

func start_cooldown() -> void:
	is_on_cooldown = true
	sprite.modulate.a = 0.5
	
	await get_tree().create_timer(cooldown_time).timeout
	
	is_on_cooldown = false
	sprite.modulate.a = 1.0
