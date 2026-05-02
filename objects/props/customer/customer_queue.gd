extends Node2D
class_name CustomerQueue


@export var laying_item_scene: PackedScene
@export_range(0.0, 1000.0, 0.1) var dispense_impulse := 100.0

@onready var interactable_area: InteractableArea = %InteractableArea
@onready var customer_sprite: AnimatedSprite2D = %Customer
@onready var queue_sprite: AnimatedSprite2D = %Queue
@onready var item_visuals: ItemVisuals = %ItemVisuals

enum Customer {
	PUNK, RICH, KACHOK, CHEF, SKATER
}
enum LavendTypes {
	DEFAULT, SEA, SUNNY
}
@export var customer := Customer.PUNK : set = _set_customer
func _set_customer(new_customer: Customer) -> void:
	customer = new_customer
	customer_sprite.frame = customer

@export var required_items: Array[ItemManager.Item] = []
## required_items mask, track which are done
var items_done: Array[bool] = []

var lavend_type_to_res: Dictionary[LavendTypes, ItemManager.Item] = {
	LavendTypes.DEFAULT: ItemManager.Item.Lavend,
	LavendTypes.SEA    : ItemManager.Item.SeaLavend,
	LavendTypes.SUNNY  : ItemManager.Item.SunnyLavend,
}

func _ready() -> void:
	interactable_area.interacted.connect(_on_interact)
	queue_sprite.speed_scale = 0.3
	queue_sprite.play("default")
	customer_sprite.speed_scale = 0.0
	customer_sprite.play("default")
	_randomize_customer()
	# _randomize_required_items(3)
	_require_coffee(1)
	print(required_items)
	print(items_done)

func _require_coffee(amount: int) -> void:
	items_done.resize(amount)
	items_done.fill(false)
	required_items = []
	for i in range(amount):
		required_items.append(ItemManager.Item.LavendCup)
	item_visuals.create_item_sprites(required_items)

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
	laying_item.global_position = global_position + Vector2(0, 64)
	laying_item.apply_impulse(Vector2.DOWN * dispense_impulse)

func _check_task_done() -> void:
	for done in items_done:
		if not done:
			return
	_task_done()

func _task_done() -> void:
	_dispense_item(ItemManager.Item.Coin)
	_randomize_customer()
	#_randomize_required_items(3)
	_require_coffee(1)

func _randomize_required_items(amount: int) -> void:
	items_done.resize(amount)
	items_done.fill(false)
	required_items = []
	for i in range(amount):
		required_items.append(
			lavend_type_to_res[
				randi() % LavendTypes.size() as LavendTypes
			]
		)
	item_visuals.create_item_sprites(required_items)

func _randomize_customer() -> void:
	var new_customer = randi() % Customer.size() as Customer
	if customer == new_customer:
		customer = (new_customer + 1) % Customer.size() as Customer
	else:
		customer = new_customer
