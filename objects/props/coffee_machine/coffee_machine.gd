extends Node2D


@export var laying_item_scene: PackedScene

@onready var item_visuals: ItemVisuals = %ItemVisuals
@onready var interactable_area: InteractableArea = %InteractableArea
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D

@export_range(0.0, 1000.0, 0.1) var dispense_impulse := 100.0
@export var recipes: Array[CoffeeRecipeResource]

var loaded_items: Array[ItemManager.Item] = []

func _ready() -> void:
	interactable_area.interacted.connect(_on_interact)
	animated_sprite.play("default")

func _on_interact(player: Player) -> void:
	if not player.has_item():
		_clear_items()
		return
	_put_item(player.get_item())
	player.remove_item()
	

func _clear_items() -> void:
	loaded_items = []
	item_visuals.clear_item_sprites()

func _put_item(item: ItemManager.Item) -> void:
	loaded_items.append(item)
	item_visuals.create_item_sprites(loaded_items)
	var recipe_match := _find_matching_recipe()
	if recipe_match == null:
		return
	_dispense_item(recipe_match.result)
	_clear_items()

func _dispense_item(item: ItemManager.Item) -> void:
	var laying_item: LayingItem = laying_item_scene.instantiate()
	YSort.y_sort_node.add_child(laying_item)
	laying_item.set_item(item)
	laying_item.global_position = global_position + Vector2(16, 32)
	laying_item.apply_impulse(Vector2.DOWN * dispense_impulse)

func _find_matching_recipe() -> CoffeeRecipeResource:
	var counts: Dictionary[ItemManager.Item, int] = {}
	for item in loaded_items:
		counts[item] = counts.get(item, 0) + 1
	for recipe in recipes:
		if _recipe_matches(counts, recipe):
			return recipe
	return null

func _recipe_matches(counts: Dictionary[ItemManager.Item, int], recipe: CoffeeRecipeResource) -> bool:
	var items_req = recipe.ingredients
	for item in items_req:
		if counts.get(item, 0) == 0:
			return false
		counts[item] -= 1
	return true
