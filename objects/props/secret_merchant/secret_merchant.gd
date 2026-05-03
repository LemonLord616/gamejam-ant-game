extends StaticBody2D
class_name SecretMerchant


@export var laying_item_scene: PackedScene
@export var dispense_impulse := 100.0

@onready var merchant_sprite: AnimatedSprite2D = %MerchantSprite
@onready var interactable_area: InteractableArea = %InteractableArea


func _ready() -> void:
	merchant_sprite.play("default")
	interactable_area.interacted.connect(_on_interact)

func _on_interact(player: Player) -> void:
	if !player.is_item(ItemManager.Item.Coin):
		return
	player.remove_item()
	_dispense_item(ItemManager.Item.Energy)

func _dispense_item(item: ItemManager.Item) -> void:
	var laying_item: LayingItem = laying_item_scene.instantiate()
	YSort.y_sort_node.add_child(laying_item)
	laying_item.set_item(item)
	laying_item.global_position = global_position + Vector2(16, 0)
	laying_item.apply_impulse(Vector2.RIGHT * dispense_impulse)
