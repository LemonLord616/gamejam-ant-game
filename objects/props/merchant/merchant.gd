extends StaticBody2D
class_name Merchant


@export var laying_item_scene: PackedScene
@export var cost_time: Curve
@export var dispense_impulse := 100.0

@onready var merchant_sprite: AnimatedSprite2D = %MerchantSprite
@onready var torch_sprite: AnimatedSprite2D = %TorchSprite
@onready var interactable_area: InteractableArea = %InteractableArea
@onready var item_visuals: ItemVisuals = %ItemVisuals

var required_items: Array[ItemManager.Item] = []
var items_done: Array[bool] = []

func _ready() -> void:
	merchant_sprite.play("default")
	torch_sprite.play("default")
	interactable_area.interacted.connect(_on_interact)
	_require_coins(1)

func _on_interact(player: Player) -> void:
	if !player.has_item():
		return
	var item = player.get_item()
	if not item in required_items:
		return
	for i in range(required_items.size()):
		if items_done[i]:
			continue
		var required_item = required_items[i]
		if required_item == item:
			player.remove_item()
			items_done[i] = true
			item_visuals.mark_done(i)
			_check_task_done()
			return

func _dispense_item(item: ItemManager.Item) -> void:
	var laying_item: LayingItem = laying_item_scene.instantiate()
	YSort.y_sort_node.add_child(laying_item)
	laying_item.set_item(item)
	laying_item.global_position = global_position + Vector2(0, 16)
	laying_item.apply_impulse(Vector2.DOWN * dispense_impulse)

func _check_task_done() -> void:
	for done in items_done:
		if not done:
			return
	_task_done()

func _task_done() -> void:
	_dispense_item(ItemManager.Item.Food)
	_require_coins(
		max(1, cost_time.sample(global_clock.timer))
	)

func _require_coins(amount: int) -> void:
	items_done.resize(amount)
	items_done.fill(false)
	required_items = []
	for i in range(amount):
		required_items.append(ItemManager.Item.Coin)
	item_visuals.create_item_sprites(required_items)
