extends RigidBody2D
class_name Player


signal item_changed(item_res: ItemResource)
signal item_picked
signal item_discarded

@export var player_id: int = 1
@export var device_id: int = 0

@export var motion_profile: MotionProfileResource
@export var controller: PlayerController
@export var floating_item: FloatingItem

@export_range(2.0, 20.0, 0.5, "sec") var run_full_duration := 5.0
@export var max_health := 10

@onready var health_component: PlayerHealth = %Health

var current_item_idx: ItemManager.Item
var current_item: ItemResource

func _ready() -> void:
	lock_rotation = true
	gravity_scale = 0.0
	controller.exit.connect(_on_exit)

func _on_exit() -> void:
	ui.hide_text()

func is_item(item_idx: ItemManager.Item) -> bool:
	if !has_item():
		return false
	return current_item_idx == item_idx

func has_item() -> bool:
	return current_item != null

func get_item() -> ItemManager.Item:
	return current_item_idx

func set_item(item_idx: ItemManager.Item) -> void:
	current_item_idx = item_idx
	current_item = ItemManager.item_resources[item_idx]
	item_changed.emit(current_item)
	item_picked.emit()

func remove_item() -> void:
	current_item = null
	current_item_idx = -1
	item_changed.emit(null)
	item_discarded.emit()

func get_damage(amount: int) -> void:
	health_component.reduce_health(amount)

func recover_health(amount: int) -> void:
	health_component.recover_health(amount)

func _physics_process(delta: float) -> void:
	apply_force(-motion_profile.damp * linear_velocity)
